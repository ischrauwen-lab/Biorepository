# Splicetools:

We refered to the [Splicetools Github](https://github.com/flemingtonlab/SpliceTools/tree/main) when the scripts were made.

## Reguarding FASTA files:

We generally used Ensembl references but Splicetools seems to prefer `chr` in front of the chromosome number so a simple command was used to add it:

```bash
sed 's/^>\([0-9]\+\)/>chr\1/' Reference_sm.primary_assembly.fa > Reference_sm.primary_assembly___chr_added.fa
```
