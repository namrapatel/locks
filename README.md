# seeds

### Opcode modules

| **Opcode**   | **Description**                                                      |
|--------------|----------------------------------------------------------------------|
| BALANCE      | Check address(balance) of submitted contract address                 |
| SLOAD        | Check if submitted contract READs from storage                       |
| SSTORE       | Check if submitted contract WRITEs to storage                        |
| CALL         | Check if submitted contract uses CALL, find address it calls         |
| DELEGATECALL | Check if submitted contract uses DELEGATECALL, find address it calls |
| STATICCALL   | Check if submitted contract uses STATICCALL, find address it calls   |
| SELFDESTRUCT | Check if submitted contract SELFDESTRUCTs                            |