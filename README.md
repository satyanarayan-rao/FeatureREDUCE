# Run featureREDUCE
Repo for running FeatureREDUCE in a virtual environment

Please install Anaconda personal [addition](https://www.anaconda.com/products/distribution) for linux. 



1. Create a virtual environment `run_freduce`

```
conda create -n run_freduce python=3.6
```

2. Activate the virtual environment `run_freduce`:

```
conda activate run_freduce
```

3. Install required packages

```
sh install_packages.sh
```

4. Unzip the FeatureREDUCE package

```
unzip FeatureREDUCE-master.zip
```

5. Go to `FeatureREDUCE-master/freduce/src` and run:

```
javac FeatureReduce.java
cp *.class ../bin
```

6. Copy envrc `FeatureREDUCE-master/freduce/.envrc`

```
cp envrc FeatureREDUCE-master/freduce/.envrc 
```

Please see the `.envrc` file already present there and change the path accordingly. Here are the tips:

- Used the command `which R` to find the path of `R` and set it as `R_HOME`

- You will find `rJava` in `$R_HOME/library/rJava` : set that as `RJAVA_HOME` 

- You need to put `libjvm.so` in `LD_LIBRARY_PATH`. `libjvm.so` can be found in you virtual library's `lib/server` directory

- In your CLASSPATH, `JRI.jar` should be present. This jar file can be found in `$RJAVA_HOME/jri/` 


7. Source the `.envrc` file

```
source FeatureREDUCE-master/freduce/.envrc
```

8. Run the snakemake pipeline to generate results (first run with `-np` flag to see if dry run looks good, then remove `-np` flag and run to generate the result)
```
snakemake -np  --snakefile run_feature_reduce.smk correlation_and_rsq/{max,mef2b,p53}_trial_{01..10}.tsv --configfile configs/config.yaml -j3
```
