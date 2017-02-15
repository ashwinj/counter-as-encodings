Software Implementation for CtMAC1, CtMAC2st and CtHAIFA

Requires AES-NI and SSE4 compatible architectures. In the following discussion we let [S] \in \{8,16,32,64\}. We also assume that
the user's current working directory is the one that contains this README file.

The measurement technique used in this implementation has been taken from Shay Gueron's white paper on AES-NI [1].

[1] Shay Gueron: Intel® Advanced Encryption Standard (Intel® AES) Instructions Set - Rev 3.01. White Paper (2012),
    https://software.intel.com/en-us/articles/intel-advanced-encryption-standard-aes-instructions-set/



1. CtMAC1	==>	stateless-deterministic

	1.1 Compilation
		$ gcc -maes -msse4 key-schedule.s ./stateless-deterministic/XXX.s \
		> ./stateless-deterministic/YYY_main.c -o ./stateless-deterministic/ZZZ

		where XXX can be one of the following:

			1.1.1 dlm	==>	CtMAC1 based on VAR^r.
				1.1.1.a Set YYY := DLM and ZZZ = DLM.

			1.1.2 kllm	==>	CtMAC1 based on STD^{opt}.
				1.1.2.a Set YYY := KLLM and ZZZ = KLLM.

			1.1.3 lm[S]	==>	CtMAC1 based on STD with s=[S].
				1.1.3.a Set YYY := LM and ZZZ = LM[S].

	1.2 Execution
		1.2.1 Without data collection.
			$ ./ZZZ

			where ZZZ can be one of DLM, KLLM, LM[S].

		1.2.2 With data collection.
			$ ./ZZZ > ./ZZZ.dat

	1.3 Output format
		Each of the above executables outputs the "<number of AES calls><space><cpb>" for message lengths starting from
		2^7 bytes to 2^25 bytes.
		

2. CtMAC2^{st}		==>	stateful-deterministic

	2.1 Compilation
		$ gcc -maes -msse4 key-schedule.s ./stateful-deterministic/XXX.s \
		> ./stateful-deterministic/YYY_main.c -o ./stateful-deterministic/ZZZ

		where XXX can be one of the following:

			2.1.1 cdxm	==>	CtMAC2^{st} based on VAR^r.
				2.1.1.a Set YYY := CDXM and ZZZ = CDXM.

			2.1.2 ckxm	==>	CtMAC2^{st} based on STD^{opt}.
				2.1.2.b Set YYY := CKXM and ZZZ = CKXM.

			2.1.3 clxm[S]	==>	CtMAC2^{st} based on STD with s=[S].
				2.1.3.c Set YYY := CLXM and ZZZ = CLXM[S].

	1.2 Execution
		1.2.1 Without data collection.
			$ ./ZZZ

			where ZZZ can be one of CDXM, CKXM, CLXM[S].

		1.2.2 With data collection.
			$ ./ZZZ > ./ZZZ.dat

	1.3 Output format
		Each of the above executables outputs the "<number of AES calls><space><cpb>" for message lengths starting from
		2^7 bytes to 2^25 bytes.


3. CtHAIFA	==>	haifa 

	3.1 Compilation
		$ gcc -maes -msse4 key-schedule.s ./haifa/XXX.s ./haifa/YYY_main.c -o ./haifa/ZZZ

		where XXX can be one of the following:

			3.1.1 dhaifa	==>	CtHAIFA based on VAR^r.
				3.1.1.a Set YYY := DHAIFA and ZZZ = DHAIFA.

			3.1.2 khaifa	==>	CtHAIFA based on STD^{opt}.
				3.1.2.a Set YYY := KHAIFA and ZZZ = KHAIFA.

			3.1.3 lhaifa[S]	==>	CtHAIFA based on STD with s=[S].
				3.1.3.a Set YYY := LHAIFA and ZZZ = LHAIFA[S].

	1.2 Execution
		1.2.1 Without data collection.
			$ ./ZZZ

			where ZZZ can be one of DHAIFA, KHAIFA, LHAIFA[S].

		1.2.2 With data collection.
			$ ./ZZZ > ./ZZZ.dat

	1.3 Output format
		Each of the above executables outputs the "<number of AES calls><space><cpb>" for message lengths starting from
		2^7 bytes to 2^25 bytes.

4. Data Assembly
	Once the data has been collected for a particular scheme for each of the counter function, run X-data-assembler to assemble
	the data in the required format. The data for table CtMAC1, CtMAC2^{st}, and CtHAIFA can be assembled using L-data-assembler, 
	C-data-assembler, and H-data-assembler, respectively. These executables produce following results for message lengths starting
	from 2^7 bytes to 2^20 bytes:
	1) X-CALLS.dat		==>	Rate offered by various schemes under X.
	2) X-CPB.dat		==>	CPB offered by various schemes under X.
	3) X-LATEX.dat		==>	CPB data parsed in latex format. First column indicating message length has to be 
					inserted manually (TODO: add code for this).

	Execution
		$ ./X-data-assembler

	where X \in \{L,C,H\}.

5. Currently Stored Results
	In each of the three folders stateless-deterministic, statelful-deterministic, and haifa we have a folder named "data" which
	contains data and graphs generated on Intel Xeon E5-2640 (Sandybridge) processor.
