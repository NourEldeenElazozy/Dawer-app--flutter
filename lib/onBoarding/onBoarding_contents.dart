class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "لنعمل معاً من أجل العيش في بيئة نظيفة",
    image: "assets/images/illust1.png",
    desc: "لضمان بيئة نظيفة وملائمة لجميع المواطنين تم إنشاء تطبيق بيئتي",
  ),
  OnboardingContents(
    title:"ساهم في الإبلاغ عن المخلفات في الشوارع",
    image:  "assets/images/illust2.png",
    desc:
        "حافظ على نظافتك ونظافة منطقتك فقط من خلال البلاغ عن أي مخلفات من داخل التطبيق",
  ),
  OnboardingContents(
    title:"أعثر على أقرب حاوية قمامة",
    image: "assets/images/illust3.png",
    desc:
        "يمكنك الأن البحيث وإيجاد جميع اماكن الحاويات في طرابلس من خلال تطبيق بيئتي",
  ),
];