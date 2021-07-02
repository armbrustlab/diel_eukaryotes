# started on 6/19/17
# for the downstream quality control and processing of Trinity-assembled transcripts

# We want to run transrate on all of our diel1 assemblies, of which there are 24


### Step one: dowload the paired end data
cd $WORKING_DIR; mkdir paired_end; cd paired_end
aws s3 cp --recursive s3://armbrustlab.diel/from_sequencing_center/QCed/combined_PE/ .

### Step two: upload the completed assemblies:
cd $WORKING_DIR; mkdir assemblies; cd assemblies
aws s3 cp --recursive s3://armbrustlab.diel/assemblies/ .

# Which version of transrate are we running?
which transrate
"/home/ubuntu/bin/transrate-1.0.3-linux-x86_64//transrate"

function diel_transrate {
WORKING_DIR="/mnt/raid/diel1"
# gather the left and right reads:
left_reads=`ls -m $WORKING_DIR/paired_end/"$1"*.1.*fastq.gz | tr -d '\n'`
right_reads=`ls -m $WORKING_DIR/paired_end/"$1"*.2.*fastq.gz | tr -d '\n'`
OUTDIR="$WORKING_DIR/transrate/$1/transrate_results"
# make a working folder for each transrate run based on the station id:
cd $WORKING_DIR/transrate; mkdir $1; cd $1
# fix the headers in the contigs file to get rid of commas:
zcat $WORKING_DIR/assemblies/diel1.all_"$1".Trinity.fasta.gz | sed 's/,/_/g' > temp.diel1.all_"$1".Trinity.fasta
# now run transrate
transrate --assembly temp.diel1.all_"$1".Trinity.fasta --left $left_reads --right $right_reads --output $OUTDIR >> $1.transrate.log
}

# Run transrate on each file:
for SAMPLE in $(ls diel.samples.txt); do
transrate ${SAMPLE}
done
