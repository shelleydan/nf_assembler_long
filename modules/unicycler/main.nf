#!/usr/bin/env nextflow

process unicycler {

        cpus 16
        memory '256 GB'
        container 'community.wave.seqera.io/library/unicycler:0.5.1--65ba988046680154'

        input:
        tuple val(sample_id), path(r1)

        output:
	path("${sample_id}/${sample_id}.fasta"), emit: assembly
	path("${sample_id}/${sample_id}.gfa"), emit: assembly_gfa
	path("${sample_id}/*"), emit: reports

        script:

	def mem_gb = task.memory.giga as int

        """
        mkdir -p ${sample_id}

        unicycler -l ${r1} \
		  -t ${task.cpus} \
		  --spades_options "-m ${mem_gb}" \
		  -o ${sample_id}

	mv "${sample_id}/assembly.fasta" "${sample_id}/${sample_id}.fasta"
	mv "${sample_id}/assembly.gfa" "${sample_id}/${sample_id}.gfa"
        """
}

