
######################################################
##### ANNOTATIONS OF ALL bf100_id99 diel CONTIGS #####
######################################################


########### DIAMOND ANNOTATION OF ALL DIEL1 CONTIGS (bf100_id99) ######

DIAMOND_DB=MarRef_w_virus.dmnd
NCORES=40
EVALUE="1e-5"
QUERY="d1.all_contigs.bf100.id99.aa.fasta"

diamond blastp --sensitive -b 65 -c 1 -t $WORKING_DIR/tmp/ -p $NCORES -d $DIAMOND_DB -e $EVALUE --top 10 -f 100 -q $QUERY -o d1.all.bf100.id99.vs_MarRef.daa


########################################################################
##### KOFAM ANNOTATION OF ALL bf100_id99 DIEL CONTIGS ######
# there is not cutoff values for KOfam given here so we must choose our own:
BITSCORE_CUTOFF=30
HMM_PROFILE=kofam_all_v1.hmm
NCORES=12
QUERY="d1.all_contigs.bf100.id99.aa.fasta"
hmmsearch -T $BITSCORE_CUTOFF --incT $BITSCORE_CUTOFF --cpu $NCORES --domtblout diel1.bf100_id99.vs_KOfam.domtblout.tab $HMM_PROFILE $QUERY

########################################################################
######### TRANSRATE BASIC ASSEMBLY STATS ON ALL DIEL
# 7/5/18:
cd /mnt/nfs/ryan/diel1/completed_assemblies/transrate_QCed/clustered/bestframe_id99/
IN_FASTA=/mnt/nfs/ryan/diel1/completed_assemblies/transrate_QCed/clustered/bestframe_id99/d1.bf100.id99.all_extract.nt.fasta
TRANSRATE_DIR=/mnt/nfs/home/rgrous83/bin/transrate-1.0.3-linux-x86_64
$TRANSRATE_DIR/transrate --assembly $IN_FASTA --threads 16
