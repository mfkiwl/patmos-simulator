# macro to simplify test definition
macro (test_asm num expr)
  ADD_TEST(asm-test-${num} ${CMAKE_BINARY_DIR}/src/paasm ${PROJECT_SOURCE_DIR}/tests/test${num}.s ${CMAKE_CURRENT_BINARY_DIR}/test${num}.bin)
  SET_TESTS_PROPERTIES(asm-test-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr})
  SET_PROPERTY(DIRECTORY APPEND PROPERTY ADDITIONAL_MAKE_CLEAN_FILES test${num}.bin)
endmacro (test_asm)

test_asm(01 "Emitted: 28 bytes
Errors : 0")

test_asm(02 "Emitted: 28 bytes
Errors : 0")

test_asm(03 "Emitted: 36 bytes
Errors : 0")

test_asm(04 "Emitted: 28 bytes
Errors : 0")

test_asm(05 "Emitted: 44 bytes
Errors : 0")

test_asm(06 "Emitted: 48 bytes
Errors : 0")

test_asm(07 "Emitted: 32 bytes
Errors : 0")

test_asm(08 "Emitted: 44 bytes
Errors : 0")

test_asm(09 "Emitted: 40 bytes
Errors : 0")

test_asm(10 "Emitted: 60 bytes
Errors : 0")

test_asm(11a "Emitted: 64 bytes
Errors : 0")

test_asm(11b "Emitted: 68 bytes
Errors : 0")

test_asm(12 "Emitted: 80 bytes
Errors : 0")

test_asm(13 "Emitted: 92 bytes
Errors : 0")

test_asm(14 "Emitted: 76 bytes
Errors : 0")

test_asm(15 "Emitted: 28 bytes
Errors : 0")

test_asm(16 "Emitted: 40 bytes
Errors : 0")

test_asm(17 "Emitted: 44 bytes
Errors : 0")

test_asm(18 "Emitted: 28 bytes
Errors : 0")

test_asm(19 "Emitted: 28 bytes
Errors : 0")

test_asm(21 "Emitted: 92 bytes
Errors : 0")

test_asm(22 "Emitted: 64 bytes
Errors : 0")

test_asm(23 "Emitted: 68 bytes
Errors : 0")

test_asm(25 "Emitted: 36 bytes
Errors : 0")

test_asm(26 "Emitted: 24 bytes
Errors : 0")

test_asm(27 "Emitted: 24 bytes
Errors : 0")

test_asm(28 "Emitted: 80 bytes
Errors : 0")

test_asm(29 "Emitted: 36 bytes
Errors : 0")

test_asm(30 "Emitted: 28 bytes
Errors : 0")

test_asm(31 "Emitted: 76 bytes
Errors : 0")

test_asm(32 "Emitted: 72 bytes
Errors : 0")

test_asm(33 "Emitted: 96 bytes
Errors : 0")

test_asm(34 "Undefined Label: x")

test_asm(35 "Emitted: 48 bytes
Errors : 0")

test_asm(36 "Emitted: 48 bytes
Errors : 0")

test_asm(37 "Emitted: 96 bytes
Errors : 0")

test_asm(38 "Emitted: 88 bytes
Errors : 0")

test_asm(39 "Emitted: 68 bytes
Errors : 0")

test_asm(40 "Emitted: 136 bytes
Errors : 0")

test_asm(41 "Emitted: 76 bytes
Errors : 0")

test_asm(42 "Emitted: 92 bytes
Errors : 0")

test_asm(43 "Emitted: 40 bytes
Errors : 0")

test_asm(44 "Emitted: 32 bytes
Errors : 0")

test_asm(45 "Emitted: 100 bytes
Errors : 0")

test_asm(48 "Emitted: 92 bytes
Errors : 0")

test_asm(49 "Emitted: 232 bytes
Errors : 0")

test_asm(50 "Emitted: 216 bytes
Errors : 0")

test_asm(51 "Emitted: 72 bytes
Errors : 0")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# SIMULATOR TESTS
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

macro (test_sim num expr)
  ADD_TEST(sim-test-${num} ${CMAKE_BINARY_DIR}/src/pasim -V --maxc 40000 -o - ${CMAKE_CURRENT_BINARY_DIR}/test${num}.bin)
  SET_TESTS_PROPERTIES(sim-test-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr} DEPENDS asm-test-${num})
endmacro (test_sim)

macro (test_dsim num expr)
  ADD_TEST(simd-test-${num} ${CMAKE_BINARY_DIR}/src/pasim -V -G 10 --maxc 40000 ${CMAKE_CURRENT_BINARY_DIR}/test${num}.bin)
  SET_TESTS_PROPERTIES(simd-test-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr} DEPENDS asm-test-${num})
endmacro (test_dsim)

macro (test_io_sim num expr)
  # Test input to program through '--in' command line argument
  ADD_TEST(sim-test-file-input-${num} ${CMAKE_BINARY_DIR}/src/pasim -V --maxc 40000 --in ${PROJECT_SOURCE_DIR}/tests/test${num}.in ${CMAKE_CURRENT_BINARY_DIR}/test${num}.bin)
  SET_TESTS_PROPERTIES(sim-test-file-input-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr} DEPENDS asm-test-${num})
  # Test input to program through stdin pipe to pasim  
  ADD_TEST(sim-test-stdin-input-${num} ${CMAKE_COMMAND}
    -DPASIM=${CMAKE_BINARY_DIR}/src/pasim
	-DTEST_BIN=${CMAKE_CURRENT_BINARY_DIR}/test${num}.bin
	-DINPUT_FILE=${PROJECT_SOURCE_DIR}/tests/test${num}.in
	-P ${CMAKE_CURRENT_SOURCE_DIR}/sim-test-stdin-input-cmd.cmake)
  SET_TESTS_PROPERTIES(sim-test-stdin-input-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr} DEPENDS asm-test-${num})
endmacro (test_io_sim)

macro (test_elf_io_sim num expr)
  # Test input to program through '--in' command line argument
  ADD_TEST(sim-test-file-input-${num} ${CMAKE_BINARY_DIR}/src/pasim -V --maxc 40000 --in ${PROJECT_SOURCE_DIR}/tests/test${num}.in ${PROJECT_SOURCE_DIR}/tests/test${num}.elf)
  SET_TESTS_PROPERTIES(sim-test-file-input-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr})
  # Test input to program through stdin pipe to pasim
  ADD_TEST(sim-test-stdin-input-${num} ${CMAKE_COMMAND}
    -DPASIM=${CMAKE_BINARY_DIR}/src/pasim
	-DTEST_BIN=${PROJECT_SOURCE_DIR}/tests/test${num}.elf
	-DINPUT_FILE=${PROJECT_SOURCE_DIR}/tests/test${num}.in
	-P ${CMAKE_CURRENT_SOURCE_DIR}/sim-test-stdin-input-cmd.cmake)
  SET_TESTS_PROPERTIES(sim-test-stdin-input-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr})
endmacro (test_elf_io_sim)

macro (test_sim_lp num expr)
  ADD_TEST(sim-test-${num} ${CMAKE_BINARY_DIR}/src/pasim -V -S lblock --maxc 40000 ${CMAKE_CURRENT_BINARY_DIR}/test${num}.bin)
  SET_TESTS_PROPERTIES(sim-test-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr})
endmacro (test_sim_lp)

macro (test_sim_scba num expr)
  ADD_TEST(sim-test-${num} ${CMAKE_BINARY_DIR}/src/pasim -V -S ablock --maxc 40000 ${CMAKE_CURRENT_BINARY_DIR}/test${num}.bin)
  SET_TESTS_PROPERTIES(sim-test-${num} PROPERTIES PASS_REGULAR_EXPRESSION ${expr})
endmacro (test_sim_scba)

test_sim(01 "r1 : 00000005   r2 : 0000000a")

test_sim(02 "r1 : 00000005   r2 : 00000005")

test_sim(03 "r1 : 00a00000   r2 : 00000000")

test_sim(04 "r1 : 00000000   r2 : 00000005")

test_sim(05 "PRR: 00000011.*
.*r1 : 00000005   r2 : 00000007   r3 : 0000000c   r4 : 00000000")

test_sim(06 "PRR: 00010011.*
.*r1 : 00000005   r2 : 00000007   r3 : 0000000c")

test_sim(07 "s2 : 00000023   s3 : 00000000")

test_sim(08 "r1 : 00000005   r2 : 00000007   r3 : 00000000   r4 : 00000023   r5 : 00000023")

test_sim(09 "r0 : 00000000   r1 : 0283f181   r2 : fffff181   r3 : fffffff1   r4 : 0000f181   r5 : 000000f1")

test_sim(10 "r0 : 00000000   r1 : 0283f181   r2 : 000000f0   r3 : 0283f181   r4 : f1810000   r5 : 81000000")

test_sim(11a "BASE: 00000004   PC : 00000040.*
.*r1 : 00000026")

test_sim(11b "BASE: 00000004   PC : 00000044.*
.*r1 : 00000029   r2 : 000000ff")

test_sim(13 "BASE: 00000004   PC : 0000002c.*
.*r1 : 0000002d   r2 : 00000004   r3 : 00000014")

test_sim(14 "r0 : 00000000   r1 : 0283f181   r2 : 0283f181   r3 : 00000283   r4 : ffffff83   r5 : 00000283   r6 : 00000083")

test_sim(15 "Unmapped memory access at 00000014: fffffffc")

test_sim(16 "Stack size exceeded at 00000020")

test_sim(17 "Stack size exceeded at 00000024")

test_sim(18 "Stack size exceeded at 0000000c")

test_sim(19 "r1 : 00000007")

test_sim(21 "BASE: 00000004   PC : 0000005c.*
.*r1 : 0000003c")

test_io_sim(22 "r1 : 000000fb")

test_sim(23 "!
.*
.*r2 : 00000021")

test_elf_io_sim(24 "1234567890")

test_sim(25 "s2 : 00000d00   s3 : 00000034")

test_sim(26 "Unaligned")

test_sim(27 "Unaligned")

test_sim(28 "BASE: 00000004   PC : 00000050.*
.*r1 : 00000026")

test_sim(29 "PRR: 00000001.*
.*r1 : 00000009   r2 : 00000001")

test_dsim(30 "r2 : 00000001")

test_dsim(31 "r2 : 00000001")

test_dsim(32 "r2 : 00000001")

test_dsim(33 "r2 : 00000001")
test_sim (33 "r2 : 00000001")

test_sim(35 "r2 : 00000001")

test_sim(36 "r2 : 00000001")

test_sim(37 "r0 : 00000000   r1 : 02820181   r2 : 02820181   r3 : 001fffe0   r4 : 001fffd0   r5 : 00000010")

test_sim(38 "r1 : 00000001")

test_sim(39 "r1 : 00000005   r2 : 00000008   r3 : 00000009   r4 : 00000001   r5 : 00000005   r6 : 00000009   r7 : 00000009")

test_sim(40 "r8 : 00000210   r9 : 00000210   r10: 00000010   r11: 000000e0   r12: 000000e0   r13: 00000210   r14: 00000100")

test_sim_lp(41 "   Blocks Not Spilled  :          8           8")

test_sim_lp(42 "   Blocks Not Spilled  :          6           6")

test_sim(43 "r0 : 00000000   r1 : 00000001   r2 : 00000005")

test_sim(44 "PRR: 00000011.*
.*r1 : 00000008   r2 : 0000000c")

test_sim_lp(45 "   Blocks Not Spilled  :        508         508")

test_sim_lp(48 "   Blocks Not Spilled  :          2           2")

test_sim_lp(49 "r1 : 00000007.*
   Blocks Spilled      :         10          10.*
   Blocks Not Spilled  :         10          10
")

test_sim_scba(50 "Align .*spill.*:          2           2
   Align .*fill.*:          0           0
   Align .*free.*:          4           4")

test_sim(51 "r1 : 00400000   r2 : 003ffffb   r3 : 00000005")
