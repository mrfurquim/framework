(function (_0x483745, _0x58dbd3) {
  const _0x53bab0 = _0x2af0,
    _0x441a17 = _0x483745();
  while (!![]) {
    try {
      const _0x337988 =
        -parseInt(_0x53bab0(0x9e)) / 0x1 +
        (parseInt(_0x53bab0(0xa1)) / 0x2) * (parseInt(_0x53bab0(0x9f)) / 0x3) +
        parseInt(_0x53bab0(0xb3)) / 0x4 +
        (parseInt(_0x53bab0(0xa6)) / 0x5) * (parseInt(_0x53bab0(0xbd)) / 0x6) +
        -parseInt(_0x53bab0(0xa8)) / 0x7 +
        parseInt(_0x53bab0(0xa3)) / 0x8 +
        (-parseInt(_0x53bab0(0xb4)) / 0x9) * (parseInt(_0x53bab0(0xb0)) / 0xa);
      if (_0x337988 === _0x58dbd3) break;
      else _0x441a17["push"](_0x441a17["shift"]());
    } catch (_0x5f441a) {
      _0x441a17["push"](_0x441a17["shift"]());
    }
  }
})(_0x1f76, 0xb9d79),
  (() => {
    const _0x2cdae9 = _0x2af0;
    Delay = (_0x1c2756) =>
      new Promise((_0x178c49) => setTimeout(_0x178c49, _0x1c2756));
    var _0x51d66e = {
        [0x197dee02]: _0x2cdae9(0x98),
        [0x62a26859]: "SETTLEMENT_AGUASDULCES",
        [0xbfd6f0a]: _0x2cdae9(0xb8),
        [-0x47f36649]: _0x2cdae9(0xb8),
        [0x704b67]: _0x2cdae9(0x9d),
        [-0x2c6016ce]: _0x2cdae9(0xb5),
        [-0x65d3eaa6]: _0x2cdae9(0xaa),
        [0x3ec4b1f5]: _0x2cdae9(0xac),
        [0x6a07dad2]: _0x2cdae9(0xae),
        [-0x7413345d]: _0x2cdae9(0xa7),
        [0x6f0248be]: _0x2cdae9(0x9a),
        [-0x6e58aed2]: "SETTLEMENT_CORNWALL_KEROSENE_TAR",
        [-0x1c32309e]: _0x2cdae9(0x99),
        [0x183ca5fa]: _0x2cdae9(0xb9),
        [0x4d704a4b]: "TOWN_MANICATO",
        [0x57350b23]: _0x2cdae9(0xb7),
        [0x79ff6291]: _0x2cdae9(0xb6),
        [-0x2da138b1]: _0x2cdae9(0xaf),
        [-0x5ae507ab]: _0x2cdae9(0xb1),
        [0x1b6880b3]: _0x2cdae9(0x9b),
        [0x7ebd16bd]: "TOWN_VANHORN",
        [0x632572af]: "SETTLEMENT_WAPITI",
      },
      _0x3c0c2a;
    function _0x1fa95c(_0x15b8b6, _0x3f1429, _0x1d372c, _0x36391b, _0x1593e6) {
      const _0x2a596c = _0x2cdae9;
      try {
        const _0x203dea = new DataView(new ArrayBuffer(0x4 * 0x4));
        _0x203dea[_0x2a596c(0xbe)](0x0, _0x1593e6, !![]);
        const _0x415117 = CreateVarString(0xa, _0x2a596c(0xad), _0x15b8b6),
          _0x3f2dfd = CreateVarString(0xa, _0x2a596c(0xad), _0x3f1429),
          _0x290970 = new DataView(new ArrayBuffer(0x30));
        _0x290970[_0x2a596c(0xbb)](0x8, BigInt(_0x415117), !![]),
          _0x290970[_0x2a596c(0xbb)](0x10, BigInt(_0x3f2dfd), !![]),
          _0x290970["setBigInt64"](0x20, BigInt(GetHashKey(_0x1d372c)), !![]),
          _0x290970["setBigInt64"](0x28, BigInt(GetHashKey(_0x36391b)), !![]),
          Citizen[_0x2a596c(0xa5)]("0x26E87218390E6729", _0x203dea, _0x290970);
      } catch (_0x75a20b) {
        setTimeout(() => {
          _0x1fa95c(_0x15b8b6, _0x3f1429, _0x1d372c, _0x36391b, _0x1593e6);
        }, 0x64);
      }
    }
    function _0x4d837b(_0x4586c3, _0xdd4549, _0xaf6d37) {
      const _0x52f0c2 = _0x2cdae9;
      let _0x1cafbb = Citizen[_0x52f0c2(0xa5)](_0x52f0c2(0xa0), 0x2);
      if (_0x1cafbb) return;
      const _0xd29f37 = new DataView(new ArrayBuffer(0x4 * 0x4));
      _0xd29f37[_0x52f0c2(0xbe)](0x0, _0xaf6d37, !![]);
      const _0x2797cd = CreateVarString(0xa, "LITERAL_STRING", _0xdd4549),
        _0xabe2bc = CreateVarString(0xa, "LITERAL_STRING", _0x4586c3),
        _0x252159 = new DataView(new ArrayBuffer(0x18));
      _0x252159[_0x52f0c2(0xbb)](0x8, BigInt(_0x2797cd), !![]),
        _0x252159[_0x52f0c2(0xbb)](0x10, BigInt(_0xabe2bc), !![]),
        Citizen[_0x52f0c2(0xa5)](
          _0x52f0c2(0xba),
          _0xd29f37,
          _0x252159,
          0x1,
          0x1
        );
    }
    var _0x2613ec = async () => {
      const _0x273e6b = _0x2cdae9;
      let _0x57cfb4 = GetEntityCoords(PlayerPedId()),
        _0x7e1d19 = Citizen["invokeNative"](
          _0x273e6b(0xa2),
          _0x57cfb4[0x0],
          _0x57cfb4[0x1],
          _0x57cfb4[0x2],
          0x1
        ),
        _0x1aedc9 = _0x51d66e[_0x7e1d19];
      if (_0x1aedc9) {
        if (_0x1aedc9 !== _0x3c0c2a) {
          SendNUIMessage({ action: _0x273e6b(0xa4), state: ![] });
          try {
            var _0x4464ef = Math[_0x273e6b(0xbc)](
                GetTemperatureAtCoords(
                  _0x57cfb4[0x0],
                  _0x57cfb4[0x1],
                  _0x57cfb4[0x2]
                )
              ),
              _0x5f0fe9 =
                GetConvar("ct_usecelsius", _0x273e6b(0x9c)) == _0x273e6b(0xa9);
            _0x5f0fe9 && (_0x4464ef = _0x4464ef * 1.8 + 0x20),
              _0x4d837b(
                "~COLOR_YELLOWLIGHT~" +
                  _0x4464ef +
                  ((_0x5f0fe9 && "F") || "ºC"),
                _0x1aedc9,
                0xe10
              );
          } catch (_0xeeef2) {
            setTimeout(_0x2613ec, 0x64);
            return;
          }
          await Delay(0xed8),
            Citizen[_0x273e6b(0xa5)](_0x273e6b(0xab), 0x2, 0x1, 0x1),
            SendNUIMessage({ action: _0x273e6b(0xa4), state: !![] });
        }
      }
      (_0x3c0c2a = _0x1aedc9), setTimeout(_0x2613ec, 0x1f4);
    };
    onNet(
      "hud:client:NativeNotification",
      (_0x164ae7, _0x4c324f, _0x3274ed, _0x3e6020, _0x4fc77c) => {
        _0x1fa95c(_0x164ae7, _0x4c324f, _0x3274ed, _0x3e6020, _0x4fc77c);
      }
    ),
      onNet(_0x2cdae9(0xb2), () => setTimeout(_0x2613ec, 0x3e8));
  })();
function _0x2af0(_0x56d567, _0x5768fe) {
  const _0x1f7667 = _0x1f76();
  return (
    (_0x2af0 = function (_0x2af061, _0x3d5a54) {
      _0x2af061 = _0x2af061 - 0x98;
      let _0x907b10 = _0x1f7667[_0x2af061];
      return _0x907b10;
    }),
    _0x2af0(_0x56d567, _0x5768fe)
  );
}
function _0x1f76() {
  const _0x48756d = [
    "SETTLEMENT_BRAITHWAITE_MANOR",
    "TOWN_SAINTDENIS",
    "370bUMaPo",
    "TOWN_TUMBLEWEED",
    "RSGCore:Client:OnPlayerLoaded",
    "1361628kncxGl",
    "328023WYjaJk",
    "TOWN_ARMADILLO",
    "TOWN_RHODES",
    "SETTLEMENT_MANZANITA_POST",
    "SETTLEMENT_AGUASDULCES",
    "SETTLEMENT_LAGRAS",
    "0xD05590C1AB38F068",
    "setBigInt64",
    "floor",
    "18thYkWP",
    "setInt32",
    "TOWN_STRAWBERRY",
    "SETTLEMENT_EMERALD_RANCH",
    "SETTLEMENT_CALIGA_HALL",
    "TOWN_VALENTINE",
    "true",
    "TOWN_ANNESBURG",
    "650834yJKtpT",
    "6hZMTMG",
    "0xC17F69E1418CD11F",
    "1504402xqrkfr",
    "0x43AD8FC02B429D33",
    "7988544dOjGzM",
    "hideIcon",
    "invokeNative",
    "1715235CkMIoU",
    "SETTLEMENT_BUTCHER_CREEK",
    "7783552oqugdW",
    "false",
    "SETTLEMENT_BEECHERS_HOPE",
    "0xDD1232B332CBB9E7",
    "TOWN_BLACKWATER",
    "LITERAL_STRING",
  ];
  _0x1f76 = function () {
    return _0x48756d;
  };
  return _0x1f76();
}
