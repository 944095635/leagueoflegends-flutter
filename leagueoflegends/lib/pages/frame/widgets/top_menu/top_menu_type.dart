enum TopMenuType {
  play(0),
  home(1),
  tft(2),
  world(3),
  // 藏品
  collection(4),
  // 战利品
  spoils(5),
  store(6),
  other(7);

  final int code;
  const TopMenuType(this.code);
}
