<img src="assets/olist-logo.svg" width="225" />

# **Marketplace tahlili**

Olist — bu marketplace agregatori sifatida ishlaydigan Braziliya elektron tijorat platformasi bo'lib, kichik bizneslarga o'z mahsulotlarini yirik elektron tijorat kanallarida 'Olist Store' orqali bevosita sotish imkonini beradi. Ushbu loyiha yetkazib berish muddati baholari va sotuvchilar sifati bo'yicha marketplace tahlilini taqdim etadi.

## Kontentlar Jadvali

- [Qamrov](#qamrov)
- [01 - Yetkazib berish muddati va'dasini optimallashtirish](#01---yetkazib-berish-muddati-vadasini-optimallashtirish)
  - [Tahlil sharhi](#tahlil-sharhi)
  - [Asosiy topilmalar](#asosiy-topilmalar)
  - [Tavsiya](#tavsiya)
- [Loyiha tafsilotlari](#loyiha-tafsilotlari)
- [Repozitoriy tuzilmasi](#repozitoriy-tuzilmasi)
- [Yo'l xaritasi](#yol-xaritasi)

## Qamrov

Bu ma'lumotlar to'plami yordamida yana bir necha savolni o'rganish mumkin bo'lsa-da, men e'tiborimni ikkita mezon asosida toraytirdim: shu to'qqizta jadval savolga haqiqatan ham javob bera oladimi va javob Olistdagi kimgadir yaxshiroq qaror qabul qilishga yordam beradimi?

Nomzodlar quyidagilar edi: takroriy xarid, kategoriya samaradorligi, sotuvchilar sifati va yuk tashish iqtisodiyoti. Takroriy xarid birinchi mezondan o'ta olmadi, chunki mijozlarning atigi ~3% i birdan ortiq buyurtma bergan; kategoriya samaradorligi esa ikkinchisidan o'ta olmadi, chunki Olist marketplace sifatida ishlaydi va o'z katalogini o'zi tanlamaydi. "Mebel yaxshi sotilyapti" degan xulosa o'z tovarini o'zi tanlaydigan do'kon uchun amaliy ma'noga ega, lekin Olist uchun bu o'sha narsa emas.

Yuk tashish narxlari bo'yicha ham qandaydir tahlil qilish mumkin bo'lsa-da, ma'lumotlar to'plamida xarajat ma'lumotlari yo'q, shuning uchun Olist yetkazib berishdan foyda ko'ryaptimi yoki zarar ko'ryaptimi — buni aniqlay olmaymiz. Sotuvchilar sifati va yetkazib berish muddatini optimallashtirish ikkala mezondan ham o'tadi.

## **01 - Yetkazib berish muddati va'dasini optimallashtirish**

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/doniyor117/olist-marketplace-analysis/blob/main/01-delivery-estimates/analysis.ipynb)
[![Notebook](https://img.shields.io/badge/notebook-view%20on%20GitHub-181717?logo=jupyter)](01-delivery-estimates/analysis.ipynb)

Taxminiy yetkazib berish sanasi — Olist bevosita nazorat qiladigan omillardan biri. Mahsulotni sotuvchilar jo'natadi, va'dani esa Olist to'lov sahifasida belgilaydi. *U mijozlarga to'liq ma'lumotlar to'plami bo'yicha odatda 23 kunlik yetkazib berish sanasini ko'rsatadi, buyurtmalar esa taxminan 10 kunda yetib keladi.* Katta zaxira vaqti va'daning buzilishidan himoya qiladi, lekin ayni paytda taklifni aslidan sekinroq ko'rsatadi, bu esa qisqaroq muddat ko'rsatayotgan raqobatchilar oldida Olistga zarar yetkazishi mumkin. Ana shu murosani ushbu tahlil o'rganadi.

Bu tahlil quyidagi savollarni beradi:

- **Taxminiy va haqiqiy yetkazib berish sanalari orasidagi farq masofa yoki mavsum kabi omillarga qarab keskin o'zgaradimi?**
- **Buzilgan va'da sharh bahosida qanchaga tushadi va qo'shimcha zaxira vaqti nima beradi?**
- **Va'da qilingan sana aslida qanday bo'lishi kerak va hozirgisini saqlab qolish bilan Olist nima yutadi va nimadan voz kechadi?**

## Tahlil sharhi:

Men farqni bevosita o'lchashdan boshladim. 2016–2018 yillar orasida yetkazib berilgan ~96 ming buyurtmaning barchasi uchun va'da qilingan sana va haqiqiy yetkazib berish sanasini oldim, ularning o'rtacha va median qiymatlarini hisobladim hamda zaxira vaqtini (yetkazib berilgan va taxminiy sanalar orasidagi kunlar) ko'rish uchun ularni ayirdim.

![observed_vs_estimated](01-delivery-estimates/figures/observed_vs_estimated_delivery_time_histplot.png)

> Chap tomondagi rasm buyurtmalarni yetkazib berish necha kun davom etganining taqsimotini ko'rsatadi va biz o'ngga qiyshaygan (right-skewed) ma'lumotni ko'rishimiz mumkin, shuning uchun asosiy o'lchovlarim uchun median dan foydalandim, chunki o'rtacha qiymatga chetdagi qiymatlar va uzun dum ta'sir qiladi. O'ng tomondagi rasm — zaxira vaqtlarining taqsimoti. Ko'pchilik buyurtmalarda yetkazib berish taxminan 10 kun davom etadi, va'da esa undan 12 kun narida turadi. E'tiborni tortadigan jihati shundaki, shunchalik katta zaxiraga qaramay, buyurtmalarning 7,6% i baribir kechikib yetib keladi.

Yetkazib berish vaqti bo'yicha mijozlar qoniqishi va xatti-harakatini bilish uchun men mijozlar sharh baholarini quyida turli zaxira vaqti oraliqlari bo'yicha ajratib ko'rib chiqdim. Oraliqlar chegaralarini topish uchun protsentillardan foydalandim. (+) buyurtma erta yetib kelganda, (-) kechikkanda.

| Zaxira oralig'i | Erta (+) / kech (−) kunlar |
| :--- | :--- |
| **very late** | −5 dan past |
| **late** | −5 dan −2 gacha |
| **slightly late** | −2 dan −1 gacha |
| **on-time** | −1 dan 0 gacha |
| **slightly early** | 0 dan 7 gacha |
| **early** | 7 dan 16 gacha |
| **very early** | 16 dan 26 gacha |
| **extremely early** | 26 dan yuqori |

![score_delivery_perform](01-delivery-estimates/figures/review_scores_by_delivery_performance.png)

> Bu yerdan ko'rinib turibdiki, kechikkan yetkazib berishlar baholarni keskin tushiradi. Hatto juda kech yetkazilgan buyurtmalarning 2/3 qismi 1 ball sharh bahosini olgan. Yana bir qiziq topilma shuki, erta yetkazib berishlar o'z vaqtida yetkazib berishlardan ham yuqoriroq baho olgan va baholar early oralig'idan keyin qanchalik katta bo'lishidan qat'i nazar tekislanib qoladi. Baho ko'rsatkichlari masofa oraliqlari bo'yicha tekshirilganda ham deyarli o'zgarmadi. Bu shuni anglatadiki, taxminiy sanani uzaytirish ma'lum bir nuqtadan keyin qo'shimcha baho keltirmaydi, kechikish esa juda qattiq zarar yetkazadi.

Kechikish erta yetkazib berishdan ancha qimmatga tushgani uchun, va'da yetkazib berish vaqtini eng yaxshi taxmin qilish bo'lmasligi kerak. O'rtacha qiymatni bashorat qilish buyurtmalarning yarmida kechikish degani bo'lardi. Aytaylik, biror yo'nalishdagi yetkazib berish vaqtlari 5, 8, 9, 12, 22 kun. O'rtacha qiymat taxminan 11. 11 kunda yetkazishni va'da qiling va 12 hamda 22 kunliklarni ikkalasi ham o'tkazib yuboriladi. Besh buyurtmadan ikkitasi kechikadi.

Shuning uchun buning o'rniga men LightGBM modelini yetkazib berish vaqtining yuqori protsentilini bashorat qilish uchun o'rgatdim, shunda va'da qilingan sana buyurtma ko'p hollarda undan oldin yetib keladigan sana bo'ladi. Tanlangan protsentil kechikish darajasini bevosita belgilaydi.

Shuningdek, oddiy state-pair hisob-kitobi ham xuddi shu ishni bajara oladimi yo'qmi tekshirish uchun har bir sotuvchi shtati va mijoz shtati juftligi bo'yicha 90-protsentil yetkazib berish vaqtini topadigan sodda baseline hisobladim.

| Usul | Kechikish darajasi (%) | O'rtacha va'da (kun) | Median va'da (kun) |
| :--- | :---: | :---: | :---: |
| **olist_native_estimates** | 4.50 | 20.94 | 20.0 |
| **baseline_estimates** | 2.18 | 21.32 | 20.0 |
| **model_estimates** | 3.44 | 17.91 | 17.0 |

Bu yerda har bir usul uchun taqqoslash jadvali keltirilgan. Test ma'lumotlarida Olist o'rtacha ~21 kunni 4,5% kechikish darajasida bashorat qilgan, bizning modelimiz esa ~18 kunni 3,44% da bergan — ikkala ko'rsatkich bo'yicha ham sezilarli darajada past. Baseline usuli kechikish darajasini ikki barobar kamaytirdi, lekin ayni paytda yetkazib berish muddatlarini Olistning taxminlaridan ham ko'proq oshirib yubordi.

![promise_reliability](01-delivery-estimates/figures/promise_vs_reliability.png)

> Turli alpha darajalari bir yutuqni boshqasiga almashtiradi. p70 da biz boshqalar orasida eng qisqa yetkazib berish muddatlarini olamiz (o'rtacha 11 kun), lekin kechikish darajasini juda ko'p oshiramiz, 10% dan ortiq. p95 da esa buning teskarisi sodir bo'ladi.

## Asosiy topilmalar

- Kechikkan yetkazib berish juda qimmatga tushadi. Juda kech yetkazilgan buyurtmalarning (5+ kun) 2/3 qismi 1 ball bilan baholangan, qo'shimcha zaxira vaqti esa 7–16 kunlik oraliqdan keyin baholarni tekislab qo'ygan.
- p90 dagi LightGBM kvantil regressiya modeli test ma'lumotlarida odatda ~18 kunlik va'dani 3,44% kechikish bilan beradi, Olistning ~21 kuni va 4,5% iga qarshi. Ayni paytda ham qisqaroq, ham ishonchliroq.
- 2018 yil davomida yetkazib berish tezlashdi, lekin va'dalar bunga ergashmadi. Iyun–oktyabr test oynasida kechikish darajasi 4,5% gacha tushadi, ya'ni zaxira vaqti Olist ilgari qanchalik sekin bo'lganiga moslab hisoblangan edi.
- Modelga eng ko'p ta'sir qilgan omillar: mijoz shtati, masofa va xarid qilingan oy. State-pair usuli oxirgi ikkitasini ko'ra olmaydi, qisqaroq va'dalar aynan shu yerdan kelib chiqadi.

## **Tavsiya:**

Men modelni p90 sozlamalari bilan ishlatishni tavsiya qilaman, chunki u ikkala ko'rsatkichni bir vaqtning o'zida yaxshilaydi: ~18 kun 3,44% kechikishda, Olistning ~21 kuni va 4,5% iga qarshi. p90 dan yuqoriga chiqish biroz ko'proq ishonchlilik beradi, lekin qisqaroq va'dani qaytarib beradi, alpha ni tanlash esa risklarga munosabat haqidagi biznes qarori.

---

## Loyiha tafsilotlari

> * **Ma'lumotlar:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
> * **Vositalar:** *Python* - pandas, numpy, matplotlib, seaborn, LightGBM, optuna, scikit-learn

## Repozitoriy tuzilmasi

```text
├── 01-delivery-estimates/
│   ├── figures/                # tahlildan eksport qilingan grafiklar
│   ├── models/
│   │   ├── delivery_p90.txt        # o'rgatilgan LightGBM kvantil modeli
│   │   └── delivery_p90_meta.json  # model uchun zarur konfiguratsiyalar
│   ├── analysis.ipynb          # yakuniy ish: topilmalar, model, tavsiya
│   └── lab.ipynb               # izlanish ishlari, muvaffaqiyatsiz urinishlar bilan
├── .gitignore
├── README.md
└── requirements.txt
```

---

## Yo'l xaritasi

> bajarildi:

- Yetkazib berish muddatini optimallashtirish - 2026 yil avgust

> keyingisi:

- Sotuvchilar sifati