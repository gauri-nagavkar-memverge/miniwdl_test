#!/usr/bin/env python3
from Bio import SeqIO
import sys

def calculate_gc(seq):
    gc_count = seq.count('G') + seq.count('C') + seq.count('g') + seq.count('c')
    total_count = len(seq)
    return (gc_count / total_count) * 100 if total_count > 0 else 0

if __name__ == "__main__":
    # Expecting the FASTA file as the first argument
    fasta_file = sys.argv[1]
    with open(fasta_file, "r") as handle:
        for record in SeqIO.parse(handle, "fasta"):
            gc_content = calculate_gc(str(record.seq))
            print(f"{record.id}\t{gc_content:.2f}%")
