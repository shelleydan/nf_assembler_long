#!/usr/bin/env nextflow

process fastp {

        cpus 4
        memory '4 GB'
        container 'community.wave.seqera.io/library/fastplong:0.4.1--73e8274104613b58'

        input:
        tuple val(sample_id), path(r1)

        output:
        tuple val(sample_id), 
	      path("${sample_id}/*_trim.fastq.gz"), emit: trimmed_reads

	path("${sample_id}/*.html"), emit: html
	path("${sample_id}/*.json"), emit: json	


        script:
        """
        mkdir -p ${sample_id}

	fastplong -i "${r1}" \
                  -o "${sample_id}/${sample_id}_trim.fastq.gz" \
                  --html "${sample_id}/${sample_id}_report.html" \
                  --json "${sample_id}/${sample_id}_report.json" \
                  --thread ${task.cpus}
        """

}

