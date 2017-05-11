#!/bin/sh

function lat_numa_trash_1core() {
	local bindcore=$1
	local bindmem=$2

	numactl --physcpubind=$bindcore --membind=$bindmem ./lat_mem_rd -P 1 -N 5 -t 32M 128
}

function lat_numa_trash_1die() {
	local binddie=$1
	local bindmem=$2

	numactl --cpubind=$binddie --membind=$bindmem ./lat_mem_rd -P 16 -N 5 -t 32M 128
}

for i in "0 16 32 48"; do
	for j in "0 1 2 3"; do
		lat_numa_trash_1core $i $j
	done
done

for i in "0 1 2 3"; do
	for j in "0 1 2 3"; do
		lat_numa_trash_1die $i $j
	done
done
