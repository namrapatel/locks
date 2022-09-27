# seeds

### Modules

| **Function name**  | **Functionality**                                                                                                   | **Relevant Opcode** | **Complete** |
|--------------------|---------------------------------------------------------------------------------------------------------------------|---------------------|--------------|
| `testfunctionname` | Check if submitted contract READs from storage                                                                      | `SLOAD`             |              |
|                    | Check if submitted contract WRITEs to storage                                                                       | `SSTORE`            |              |
|                    | Check if submitted contract uses `CALL`, find address it calls, check against blacklist                             | `CALL`              |              |
|                    | If submitted contract uses `CALL`, check call address and function signature being called against blacklist         | `CALL`              |              |
|                    | Check if submitted contract uses `DELETGATECALL`, find address it calls, check against blacklist                    | `DELEGATECALL`      |              |
|                    | If submitted contract uses `DELEGATECALL`, check call address and function signature being called against blacklist | `DELEGATECALL`      |              |
|                    | Check if submitted contract uses `STATICCALL`, find address it calls, check against blacklist                       | `STATICCALL`        |              |
|                    | If submitted contract uses `STATICCALL`, check call address and function signature being called against blacklist   | `STATICCALL`        |              |
|                    | Check if submitted contract `SELFDESTRUCT`s                                                                         | `SELFDESTRUCT`      |              |