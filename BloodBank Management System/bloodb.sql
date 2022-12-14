PGDMP     1    1             	    z            bloodb    14.2    14.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    49757    bloodb    DATABASE     j   CREATE DATABASE bloodb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE bloodb;
                postgres    false            ?            1259    49874 
   blood_unit    TABLE     e   CREATE TABLE public.blood_unit (
    id integer NOT NULL,
    blood_group text,
    count integer
);
    DROP TABLE public.blood_unit;
       public         heap    postgres    false            ?            1259    49873    blood_unit_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.blood_unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.blood_unit_id_seq;
       public          postgres    false    214                       0    0    blood_unit_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.blood_unit_id_seq OWNED BY public.blood_unit.id;
          public          postgres    false    213            ?            1259    49777    donor    TABLE     U  CREATE TABLE public.donor (
    id integer NOT NULL,
    donor_name character varying,
    age integer,
    contact bigint,
    blood_group character varying,
    status_of_blood_sample character varying,
    donation_date date DEFAULT CURRENT_TIMESTAMP,
    password character varying,
    CONSTRAINT donor_age_check CHECK ((age >= 18))
);
    DROP TABLE public.donor;
       public         heap    postgres    false            ?            1259    49776    donor_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.donor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.donor_id_seq;
       public          postgres    false    210                       0    0    donor_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.donor_id_seq OWNED BY public.donor.id;
          public          postgres    false    209            ?            1259    49787    purchase_record    TABLE     ?   CREATE TABLE public.purchase_record (
    id integer NOT NULL,
    buyer_name character varying,
    contact bigint,
    quantity integer,
    password character varying
);
 #   DROP TABLE public.purchase_record;
       public         heap    postgres    false            ?            1259    49786    purchase_record_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.purchase_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.purchase_record_id_seq;
       public          postgres    false    212                       0    0    purchase_record_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.purchase_record_id_seq OWNED BY public.purchase_record.id;
          public          postgres    false    211            j           2604    49877    blood_unit id    DEFAULT     n   ALTER TABLE ONLY public.blood_unit ALTER COLUMN id SET DEFAULT nextval('public.blood_unit_id_seq'::regclass);
 <   ALTER TABLE public.blood_unit ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    213    214            f           2604    49780    donor id    DEFAULT     d   ALTER TABLE ONLY public.donor ALTER COLUMN id SET DEFAULT nextval('public.donor_id_seq'::regclass);
 7   ALTER TABLE public.donor ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            i           2604    49790    purchase_record id    DEFAULT     x   ALTER TABLE ONLY public.purchase_record ALTER COLUMN id SET DEFAULT nextval('public.purchase_record_id_seq'::regclass);
 A   ALTER TABLE public.purchase_record ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    212    212            ?          0    49874 
   blood_unit 
   TABLE DATA           <   COPY public.blood_unit (id, blood_group, count) FROM stdin;
    public          postgres    false    214   |       ?          0    49777    donor 
   TABLE DATA           {   COPY public.donor (id, donor_name, age, contact, blood_group, status_of_blood_sample, donation_date, password) FROM stdin;
    public          postgres    false    210   ?       ?          0    49787    purchase_record 
   TABLE DATA           V   COPY public.purchase_record (id, buyer_name, contact, quantity, password) FROM stdin;
    public          postgres    false    212   \       	           0    0    blood_unit_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.blood_unit_id_seq', 16, true);
          public          postgres    false    213            
           0    0    donor_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.donor_id_seq', 5, true);
          public          postgres    false    209                       0    0    purchase_record_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.purchase_record_id_seq', 5, true);
          public          postgres    false    211            l           2606    49785    donor donor_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.donor
    ADD CONSTRAINT donor_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.donor DROP CONSTRAINT donor_pkey;
       public            postgres    false    210            n           2606    49794 $   purchase_record purchase_record_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.purchase_record
    ADD CONSTRAINT purchase_record_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.purchase_record DROP CONSTRAINT purchase_record_pkey;
       public            postgres    false    212            ?   :   x?3?t??4?2?t?R&?N ????2?t??i]Nc.sNmNC.CNG???? ??      ?   ?   x?e?K?0????V??{o???t?Dݿ4?1??_?1ȷ???b?Ԕ?~j;e???????C???z???<I??B;?gXmm?}m??	?~}N?Ļ/????\ʤ?aG??+?????eܠJ??K?0      ?   x   x??A
?0???1?????? ??؄?P;??>?A?v`?\???ay?d?Mxv??Y?Y&t?jt??Q?n?ȪQc7??i?p???i?c?kK???\?g?????qͿ?<?r#?c&o     