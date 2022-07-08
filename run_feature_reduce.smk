rule prepare_data:
    input:
        selex_file = lambda wildcards: config["selex_data"][wildcards.tf]
    output:
        freduce_compatible_data = "freduce_formatted/{tf}.tsv" 
    shell:
        "sh scripts/get_selex_data.sh {input.selex_file} {output.freduce_compatible_data} {wildcards.tf}"
        
rule split_train_test:
    input:
        freduce_compatible_data = "freduce_formatted/{tf}.tsv" 
    output:
        train_out = "train_test_data/{tf}_trial_{trial}_train.tsv",
        test_out = "train_test_data/{tf}_trial_{trial}_test.tsv", 
        test_template = "train_test_data/{tf}_trial_{trial}_template.tsv"
    shell:
        "bash scripts/split.sh {input.freduce_compatible_data} {output.train_out}"
        " {output.test_out} {output.test_template}"

rule run_featureREDUCE:
    input: 
        train_out = "train_test_data/{tf}_trial_{trial}_train.tsv",
        test_template = "train_test_data/{tf}_trial_{trial}_template.tsv", 
        freduce_init = "freduce.init"
    output:
        pred_out = "prediction/{tf}_trial_{trial}_pred.tsv", 
        log_out = "logs/{tf}_trial_{trial}.log"
    shell:
        "java -Xmx5000M FeatureReduce {input.freduce_init} -c 0 2 3 -ids {wildcards.tf}"
        " -kmer -l selex -i {input.train_out} -a {input.test_template}"
        " -o {output.pred_out} -displayMotifs No 2>&1 | tee {output.log_out}"

rule get_correlation: 
    input:
        test_out = "train_test_data/{tf}_trial_{trial}_test.tsv", 
        pred_out = "prediction/{tf}_trial_{trial}_pred.tsv"
    output:
        metric = "correlation_and_rsq/{tf}_trial_{trial}.tsv"
    shell:
        "Rscript scripts/cor_or_rsq.R {input.test_out} {input.pred_out} trial_{wildcards.trial} {wildcards.tf} > {output.metric}"
       
    
