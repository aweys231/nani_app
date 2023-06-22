class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.Desc ='',
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  String Desc;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/images/Driver.png',
      titleTxt: 'Driver',
      kacl: 525,
      Desc: 'Transport finished goods and raw materials over land to manufacturing plants or retail distribution centers',
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/images/Clear.png',
      titleTxt: 'Clear',
      kacl: 602,
      Desc: 'Includes cleaning the house, cooking, washing and ironing clothes, taking care of children ',
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/images/Security.png',
      titleTxt: 'Security',
      kacl: 0,
      Desc: 'Secures premises and personnel by patrolling property, monitoring surveillance equipment',
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/images/Health_care.png',
      titleTxt: 'Health Care',
      kacl: 0,
      Desc: 'observing, monitoring and recording patients\' conditions by taking temperatures',
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
