# locks

A library that searches for the use of certain opcodes in a contract and returns a boolean value indicating whether or not the contract uses the opcode. The following table describes the opcodes that the library currently supports. 

**Note:** While the library is able to detect the use of an opcode, a bad actor could simply overcome the detection of specific addresses being called by passing in a dynamic address to the CALL at runtime. Since the library basically just loops over the bytecode and looks for the presence of the opcode, it is unable to detect the use of dynamic addresses.

| **Function name** | **Functionality**                                                                                                   | **Relevant Opcode** | **Status** |
| ----------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------- | ------------ |
| `checkSLOAD`      | Check if submitted contract READs from storage                                                                      | `SLOAD`             | Complete     |
| `checkSSTORE`     | Check if submitted contract WRITEs to storage                                                                       | `SSTORE`            | Complete     |
| `checkCall`       | Check if submitted contract uses `CALL`, find address it calls, check against blacklist                             | `CALL`              | Impossible?  |
| `checkCallAndFunction`| If submitted contract uses `CALL`, check call address and function signature being called against blacklist     | `CALL`              | Impossible?  |
| `checkCall`       | Check if submitted contract uses `DELETGATECALL`, find address it calls, check against blacklist                    | `DELEGATECALL`      | Impossible?  |
| `checkCallAndFunction`| If submitted contract uses `DELEGATECALL`, check call address and function signature being called against blacklist | `DELEGATECALL`      | Impossible?  |
|                   | Check if submitted contract uses `STATICCALL`, find address it calls, check against blacklist                       | `STATICCALL`        | Impossible?  |
|                   | If submitted contract uses `STATICCALL`, check call address and function signature being called against blacklist   | `STATICCALL`        | Impossible?  |
|                   | Check if submitted contract `SELFDESTRUCT`s                                                                         | `SELFDESTRUCT`      | Impossible?  |