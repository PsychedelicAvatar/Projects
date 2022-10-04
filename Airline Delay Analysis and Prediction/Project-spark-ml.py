import pickle
from pyspark.sql import SparkSession
from pyspark.ml.classification import LogisticRegression
from pyspark.sql.functions import col


def ml_transform():
    df = spark.read.parquet("s3://dbda-final-project10/hive/2018")
    bd1 = df.withColumn('Delayed', (df.ARR_DELAY >=15).cast('int')) 
    bd1.createOrReplaceTempView("bd1")
    bd1 = spark.sql("select *, case \
                when DEP_TIME <= 800 then 1 \
                when 800 < DEP_TIME and DEP_TIME <= 1200 then 2 \
                when 1200 < DEP_TIME and DEP_TIME <= 1600 then 3 \
                when 1600 < DEP_TIME and DEP_TIME <= 2100 then 4 \
                else 1 end as TimeSlot \
                from bd1")

    bd1=bd1.withColumn("FL_DAYOFWEEK",col("FL_DAYOFWEEK").cast('double'))
    bd1=bd1.withColumn("FL_MONTH",col("FL_MONTH").cast('double'))
    bd1=bd1.withColumn("TimeSlot",col("TimeSlot").cast('double'))
    bd1=bd1.withColumn("Delayed",col("Delayed").cast('double'))

    from pyspark.ml.feature import StringIndexer
    indexer1 = StringIndexer(inputCol='OP_CARRIER',outputCol='INDEX_CARRIER') 
    bd2=indexer1.fit(bd1).transform(bd1)
    indexer2 = StringIndexer(inputCol='ORIGIN',outputCol='INDEX_ORIGIN') 
    bd3=indexer2.fit(bd2)
    bd4=bd3.transform(bd2)
    bd5=bd4.select('DEP_DELAY',
                'DISTANCE', 
                'FL_DAYOFWEEK',
                'INDEX_CARRIER', 
                'TimeSlot',
                'Delayed',
                'FL_MONTH',
                'ACTUAL_ELAPSED_TIME',
                'INDEX_ORIGIN')

            
    from pyspark.ml.feature import Imputer
    imputer = Imputer(
        inputCols = bd5.columns,
        outputCols = ["{}".format(a) for a in bd5.columns]
    ).setStrategy("median")
    bd6=imputer.fit(bd5)
    bd7=bd6.transform(bd5)


    from pyspark.ml.feature import OneHotEncoder
    encoder = OneHotEncoder(inputCol="INDEX_ORIGIN", outputCol="VEC_ORIGIN")
    encoder.setDropLast(False)
    bd8 = encoder.fit(bd7)
    bd7=bd8.transform(bd7)


    from pyspark.ml.feature import VectorAssembler, StringIndexer  
    from pyspark.sql.functions import col

    a1 = VectorAssembler(  
    inputCols=['DEP_DELAY',
                'DISTANCE', 
                'FL_DAYOFWEEK',
                'INDEX_CARRIER', 
                'TimeSlot',
                'FL_MONTH',
                'ACTUAL_ELAPSED_TIME',
                'INDEX_ORIGIN'], 
    outputCol='features')

    bd7 = a1.transform(bd7).select(col("Delayed").cast('double').alias("label"),'features')  
    stringIndexer = StringIndexer(inputCol = 'label', outputCol = 'label2')  
    sI = stringIndexer.fit(bd7)  
    bd7 = sI.transform(bd7)  
    bd7 = bd7.select('label2','features')  

    from pyspark.ml.feature import StandardScaler
    scaler=StandardScaler ().setInputCol ("features")\
    .setOutputCol ("features_scaled")
    scaler_model=scaler.fit(bd7)
    scaler_df=scaler_model.transform(bd7)
    global train,test
    train, test = scaler_df.randomSplit([0.7, 0.3], seed = 123)

def ml_training():
    global lrModel
    lr=LogisticRegression (featuresCol = 'features', labelCol ='label2', maxIter=5)
    lrModel=lr.fit(train)

def dump_model():
    pickle.dump(lrModel, open('lrModel.pkl', 'wb'))

if __name__ == "__main__":
    spark = SparkSession.builder.getOrCreate()
    ml_transform()
    ml_training()
    dump_model()








    




