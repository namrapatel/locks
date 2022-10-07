# locks

| **Function name** | **Functionality**                                                                                                   | **Relevant Opcode** | **Status** |
| ----------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------- | ------------ |
| `checkSLOAD`      | Check if submitted contract READs from storage                                                                      | `SLOAD`             | Complete     |
| `checkSSTORE`     | Check if submitted contract WRITEs to storage                                                                       | `SSTORE`            | Complete     |
|                   | Check if submitted contract uses `CALL`, find address it calls, check against blacklist                             | `CALL`              | Impossible?  |
|                   | If submitted contract uses `CALL`, check call address and function signature being called against blacklist         | `CALL`              | Impossible?  |
|                   | Check if submitted contract uses `DELETGATECALL`, find address it calls, check against blacklist                    | `DELEGATECALL`      | Impossible?  |
|                   | If submitted contract uses `DELEGATECALL`, check call address and function signature being called against blacklist | `DELEGATECALL`      | Impossible?  |
|                   | Check if submitted contract uses `STATICCALL`, find address it calls, check against blacklist                       | `STATICCALL`        | Impossible?  |
|                   | If submitted contract uses `STATICCALL`, check call address and function signature being called against blacklist   | `STATICCALL`        | Impossible?  |
|                   | Check if submitted contract `SELFDESTRUCT`s                                                                         | `SELFDESTRUCT`      | Impossible?  |