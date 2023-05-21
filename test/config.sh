#!/bin/bash
set -e

testAlias+=(
	[kylacoind:trusty]='kylacoind'
)

imageTests+=(
	[kylacoind]='
		rpcpassword
	'
)
