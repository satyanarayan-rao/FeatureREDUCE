# Run featureREDUCE
Repo for running FeatureREDUCE in a virtual environment

Please install Anaconda personal [addition](https://www.anaconda.com/products/distribution) for linux. 

1. Downlaod the repo: `curl -JLO https://codeload.github.com/FeatureREDUCE/FeatureREDUCE/zip/refs/heads/master` 


2. Create a virtual environment `run_freduce`

```
conda create -n run_freduce python=3.6
```

3. Activate the virtual environment `run_freduce`:

```
conda activate run_freduce
```

4. Install required packages

```
sh install_packages.sh
```

5. Unzip the FeatureREDUCE package

```
unzip FeatureREDUCE-master.zip
```

6. Go to `FeatureREDUCE-master/freduce/src` and run:

```
javac FeatureReduce.java
cp *.class ../bin
```


7. Go to `FeatureREDUCE-master/freduce/` directory and create .envrc file

Please see the `.envrc` file already present there and change the path accordingly. 


8. Go to the `FeatureREDUCE-master/freduce/demo/dream5` and run:

```
bash fitModel.sh
```
