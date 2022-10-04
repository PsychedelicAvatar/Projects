
from pyspark.sql import SparkSession
from pyspark.sql.functions import to_date
from pyspark.sql.functions import col
from pyspark.sql.types import *
from pyspark.sql.functions import regexp_replace
from pyspark.sql.functions import year
from pyspark.sql.functions import month
from pyspark.sql.functions import dayofweek
import pickle

def extract():
    global df
    df=spark.read.format("csv").option("header","true").option("inferSchema",'True').load(f's3://dbda-prj10-trigger/2018.csv')

def transform():
    global df1
    c=df.count()
    for i in df.columns:
        if (((df.filter(df[i].isNull()).count())/c)*100)>80:
            df=df.drop(i)

    df=df.withColumn("FL_DATE",to_date(col("FL_DATE"),"yyyy-MM-dd"))

    df = df.withColumn("OP_CARRIER_FL_NUM",df["OP_CARRIER_FL_NUM"].cast(StringType()))

    l={'UA':'United Airlines',
        'AS':'Alaska Airlines',
        '9E':'Endeavor Air',
        'B6':'JetBlue Airways',
        'EV':'ExpressJet',
        'F9':'Frontier Airlines',
        'G4':'Allegiant Air',
        'HA':'Hawaiian Airlines',
        'MQ':'Envoy Air',
        'NK':'Spirit Airlines',
        'OH':'PSA Airlines',
        'OO':'SkyWest Airlines',
        'VX':'Virgin America',
        'WN':'Southwest Airlines',
        'YV':'Mesa Airline',
        'YX':'Republic Airways',
        'AA':'American Airlines',
        'DL':'Delta Airlines'}
    l=list(l.items())
    for i in range(18):
        df=df.withColumn('OP_CARRIER', regexp_replace('OP_CARRIER', l[i][0], l[i][1]))

    df1=df.filter(df['ARR_DELAY']>0)

    df1=df1.withColumn('FL_YEAR',year(df1.FL_DATE))
    df1=df1.withColumn('FL_DAYOFWEEK',dayofweek(df1.FL_DATE))
    df1=df1.withColumn('FL_MONTH',month(df1.FL_DATE))

def spark_to_hive():
    s3_location = 's3://dbda-final-project10/hive/'
    df1.write.mode('overwrite').saveAsTable(f'airline_schema.airline_2018', path=s3_location)

def ml_output_to_s3():
    lrModel=pickle.load(lrModel, open('lrModel.pkl', 'wb'))
    pred_lr=lrModel.predict()
    pred_lr.write.csv('s3://dbda-final-project10/ml-output/lr_model.csv')


if __name__ == "__main__":
    spark = SparkSession.builder.enableHiveSupport().getOrCreate()
    extract()
    transform()
    spark_to_hive()
    ml_output_to_s3()







