-- Register the Python UDF script
REGISTER 'hdfs:///pig/ex3/uppercase.py' USING jython AS myudf;

-- Load the input file from HDFS
data = LOAD 'hdfs:///pig/ex3/data.txt' USING PigStorage(',') AS (line: chararray);

-- Apply the UDF to convert each line to uppercase
uppercased_data = FOREACH data GENERATE myudf.to_upper(line);

-- Store the result in HDFS
STORE uppercased_data INTO 'hdfs:///pig/ex3/output' USING PigStorage(',');