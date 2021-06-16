import argparse
import hashlib
from pyfaidx import Fasta

parser = argparse.ArgumentParser()
parser.add_argument("fasta")
args = parser.parse_args()

fasta = Fasta(args.fasta)
for record in fasta:
    print(record.name + '\t' + hashlib.md5(record[:].seq.encode()).hexdigest())
