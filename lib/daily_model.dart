///{
//     "region": "Toshkent",
//     "date": "2022-04-11",
//     "weekday": "Dushanba",
//     "times": {
//         "tong_saharlik": "04:26",
//         "quyosh": "05:50",
//         "peshin": "12:24",
//         "asr": "17:03",
//         "shom_iftor": "19:04",
//         "hufton": "20:18"
//     }
// }
class DailyModel {
  String region;
  String date;
  String weekday;
  String bomdod;
  String peshin;
  String asr;
  String shom;
  String xufton;

  DailyModel({
    required this.region,
    required this.date,
    required this.weekday,
    required this.bomdod,
    required this.peshin,
    required this.asr,
    required this.shom,
    required this.xufton,
});

}