on('legends-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS', (args) => {
    const struct = new DataView(new ArrayBuffer(512));
    struct.setBigInt64(0, BigInt(args[2]), true);
    struct.setBigInt64(8, BigInt(args[3]), true);
    struct.setBigInt64(240, BigInt(CreateVarString(10, "LITERAL_STRING", args[4])), true);

    Citizen.invokeNative("0x139805C2A67C4795", args[0], args[1], struct, 1.0, 0, 0, 0);
});
