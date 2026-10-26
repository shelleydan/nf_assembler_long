#!/usr/bin/env nextflow

process fastqc {

	cpus 4
	memory '4 GB'
	container 'community.wave.seqera.io/library/fastqc:0.12.1--9971ea336a9eddae'

	input:
	tuple val(sample_id), path(r1)	

	output:
	path("${sample_id}/*"), emit: fastqc_raw_reports
	
	script:
	"""
	mkdir -p ${sample_id}

	fastqc -q -t ${task.cpus} ${r1} -o "${sample_id}"
	"""

}
