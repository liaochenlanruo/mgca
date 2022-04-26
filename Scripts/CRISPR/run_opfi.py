#!/usr/bin/env python
from gene_finder.pipeline import Pipeline
import os
import csv
import sys
import argparse
import shutil
from operon_analyzer import load, visualize
from operon_analyzer import analyze, rules


__version__ = '1.0.0'

__Author__ = 'Hualin Liu'

def get_options():
    import argparse

    # create the top-level parser
    description = "Finding CRISPR-Cas systems in genomics or metagenomics datasets"

    parser = argparse.ArgumentParser(description = description,
                                     prog = 'run_opfi.py')

    parser.add_argument('--genome', action='store',
                        help='genome file', default='')

    parser.add_argument('--casDBpath', action='store',
                        help='The full path of cas database, not include the database name and the last "/" of the path', default='')

    parser.add_argument('--threads', action='store',
                        default='6',
                        help='number of threads to use')

    parser.add_argument('--version', action='version',
                         version='%(prog)s '+__version__)

    return parser.parse_args()


options = get_options()

# Step 1: Finding CRISPR-Cas systems use permissive BLAST parameters intially

genomic_data = options.genome
output_directory = options.genome + '_intially'

if os.path.exists(output_directory):
    shutil.rmtree(output_directory)

os.mkdir(output_directory)
cas1_db = options.casDBpath + '/cas1_db'
cas_all_but_1_db = options.casDBpath + '/cas_all_but_1_db'
p = Pipeline()
p.add_seed_step(db=cas1_db, name="cas1", e_val=0.001, blast_type="PROT", num_threads=options.threads)
p.add_filter_step(db=cas_all_but_1_db, name="cas_all", e_val=0.001, blast_type="PROT", num_threads=options.threads)
p.add_crispr_step()

# use the input filename as the job id
# results will be written to the file <job id>_results.csv
job_id = os.path.basename(genomic_data)
results = p.run(job_id=job_id, data=genomic_data, output_directory=output_directory, min_prot_len=90, span=10000, gzip=False)

feature_colors = { "cas1": "lightblue",
                    "cas2": "seagreen",
                    "cas3": "gold",
                    "cas4": "springgreen",
                    "cas5": "darkred",
                    "cas6": "thistle",
                    "cas7": "coral",
                    "cas8": "red",
                    "cas9": "palegreen",
                    "cas10": "yellow",
                    "cas11": "tan",
                    "cas12": "orange",
                    "cas13": "saddlebrown",
                    "casphi": "olive",
                    "CRISPR array": "purple"
                    }

result_csv = output_directory + '/' + job_id + '_results.csv'
# read in the output from Gene Finder and create a gene diagram for each cluster (operon)
with open(result_csv, "r") as operon_data:
    operons = load.load_operons(operon_data)
    visualize.plot_operons(operons=operons, output_directory=output_directory, feature_colors=feature_colors, nucl_per_line=25000)


# Step 2: Filter and classify CRISPR-Cas systems based on genomic composition

output_directory2 = options.genome + '_filtered'

if os.path.exists(output_directory2):
    shutil.rmtree(output_directory2)

os.mkdir(output_directory2)

fs = rules.FilterSet().pick_overlapping_features_by_bit_score(0.9)
cas_types = ["I", "II", "III", "V"]

rulesets = []
# type I rules
rulesets.append(rules.RuleSet().contains_group(feature_names = ["cas5", "cas7"], max_gap_distance_bp = 1000, require_same_orientation = True) \
                            .require("cas3"))
# type II rules
rulesets.append(rules.RuleSet().contains_at_least_n_features(feature_names = ["cas1", "cas2", "cas9"], feature_count = 3) \
                            .minimum_size("cas9", 3000))
# type III rules
rulesets.append(rules.RuleSet().contains_group(feature_names = ["cas5", "cas7"], max_gap_distance_bp = 1000, require_same_orientation = True) \
                            .require("cas10"))
# type V rules
rulesets.append(rules.RuleSet().contains_at_least_n_features(feature_names = ["cas1", "cas2", "cas12"], feature_count = 3))

for rs, cas_type in zip(rulesets, cas_types):
    with open(result_csv, "r") as input_csv:
        filter_out = output_directory2 + '/' + job_id + '_filtered_type' + cas_type + '.csv'
        with open(filter_out, "w") as output_csv:
            analyze.evaluate_rules_and_reserialize(input_csv, rs, fs, output_csv)
        if os.path.exists(filter_out):
            print(filter_out, "is exists!")
            sz = os.path.getsize(filter_out)
            if not sz:
                print(filter_out, "is empty!")
                os.remove(filter_out)
                print("The empty file", filter_out, "is removed!")
            else:
                print(filter_out, "size is", sz)
                # read in the output from Gene Finder and create a gene diagram for each cluster (operon)
                with open(filter_out, "r") as operon_data:
                    operons = load.load_operons(operon_data)
                    visualize.plot_operons(operons=operons, output_directory=output_directory2, feature_colors=feature_colors, nucl_per_line=25000)
        else:
            print(filter_out, "is not exists!")

