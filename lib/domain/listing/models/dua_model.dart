import 'dart:convert';

/// status : true
/// message : "Duas fetched successsfully"
/// data : [{"id":1,"category":"Morning","title":"Morning Dua","arabic":"اللّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ","transliteration":"അല്ലാഹുമ്മ ബിക അസ്വ്ബഹ്‌നാ, വ ബിക അംസയ്‌നാ, വ ബിക നഹ്‌യാ, വ ബിക നമൂത്തു, വ ഇലയ്ക്കന്നുശൂർ.","translation":"അല്ലാഹുവേ, നിന്നിലൂടെ ഞങ്ങൾ പ്രഭാതം ആരംഭിക്കുന്നു, നിന്നിലൂടെ ഞങ്ങൾ വൈകുന്നേരം അവസാനിക്കുന്നു, നിന്നാൽ ഞങ്ങൾ ജീവിക്കുന്നു, നിന്നാൽ ഞങ്ങൾ മരിക്കുന്നു, നിന്നിലേക്കാണ് ഞങ്ങളുടെ മടക്കം."},{"id":2,"category":"Evening","title":"Evening Dua","arabic":"اللّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ","transliteration":"അല്ലാഹുമ്മ ബിക അംസയ്‌നാ, വ ബിക അസ്വ്ബഹ്‌നാ, വ ബിക നഹ്‌യാ, വ ബിക നമൂത്തു, വ ഇലയ്ക്കൽമസ്വീർ.","translation":"അല്ലാഹുവേ, നിന്നിലൂടെ ഞങ്ങൾ സായാഹ്നം അവസാനിപ്പിക്കുന്നു, നിന്നിലൂടെ ഞങ്ങൾ പ്രഭാതം ആരംഭിക്കുന്നു, നിന്നാൽ ഞങ്ങൾ ജീവിക്കുന്നു, നിന്നാൽ ഞങ്ങൾ മരിക്കുന്നു, നിന്നിലേക്കാണ് ഞങ്ങളുടെ മടക്കം."},{"id":3,"category":"Travel","title":"Travel Dua","arabic":"سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَىٰ رَبِّنَا لَمُنْقَلِبُونَ","transliteration":"സുബ്ഹാനല്ലദീ സഹ്ഹറ ലനാ ഹാദാ വമാ കുന്നാ ലഹൂ മുഖ്‌രിനീന വ ഇന്നാ ഇലാ റബ്ബിനാ ലമുൻഖലിബൂൻ","translation":"ഇത് (വാഹനം) ഞങ്ങൾക്ക് കീഴ്പെടുത്തിയവന് മഹത്വം, ഞങ്ങൾക്ക് ഇത് (സ്വയം) ഒരിക്കലും ചെയ്യാൻ കഴിയുമായിരുന്നില്ല, തീർച്ചയായും ഞങ്ങളുടെ നാഥനിലേക്ക് ഞങ്ങൾ മടങ്ങിവരും."},{"id":4,"category":"Forgiveness","title":"Dua for Forgiveness","arabic":"اللّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّي","transliteration":"അല്ലാഹുമ്മ ഇന്നക അഫുവ്വുൻ തുഹിബ്ബുൽ അഫ്‌വ ഫഅ്ഫു അന്നീ.","translation":"അല്ലാഹുവേ, നീ പൊറുക്കുന്നവനും ക്ഷമയെ സ്നേഹിക്കുന്നവനുമാണ്, അതിനാൽ എന്നോട് ക്ഷമിക്കൂ."},{"id":5,"category":"Protection","title":"Dua for Protection","arabic":"بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ","transliteration":"ബിസ്മില്ലാഹില്ലദീ ലാ യളുറ്‌റു മ‌അസ്മിഹീ ശയ്ഉൻ ഫിൻ അൾളി വലാ ഫിസ്സമാഇ വഹുവസ്സമീഉൽ അലീം.","translation":"അല്ലാഹുവിൻ്റെ നാമത്തിൽ, ഭൂമിയിലോ ആകാശങ്ങളിലോ ഉള്ള യാതൊന്നും ഉപദ്രവിക്കാത്തവനും അവൻ എല്ലാം കേൾക്കുന്നവനും അറിയുന്നവനുമാണ്."},{"id":6,"category":"Sleep","title":"Dua Before Sleep","arabic":"اللّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا","transliteration":"അല്ലാഹുമ്മ ബിസ്മിക അമൂത്തു വ അഹ്‌യാ.","translation":"അല്ലാഹുവേ, നിൻ്റെ നാമത്തിൽ ഞാൻ മരിക്കുകയും ജീവിക്കുകയും ചെയ്യുന്നു."},{"id":7,"category":"Waking Up","title":"Dua After Waking Up","arabic":"الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ","transliteration":"അൽഹംദു ലില്ലാഹില്ലദീ അഹ്‌യാനാ ബഅ്ദ മാ അമാത്തനാ വ ഇലയ്ഹിന്നുശൂർ.","translation":"നമ്മെ മരിപ്പിച്ചതിന് ശേഷം നമുക്ക് ജീവൻ നൽകിയ അല്ലാഹുവിനാണ് എല്ലാ സ്തുതിയും, പുനരുത്ഥാനവും അവനാണ്."},{"id":8,"category":"Before Eating","title":"Dua Before Eating","arabic":"اللَّهُمَّ بَارِكْ لَنَا فِيمَا رَزَقْتَنَا وَقِنَا عَذَابَ النَّارِ","transliteration":"അല്ലാഹുമ്മ ബാരിക് ലനാ ഫീമാ റസഖ്‌തനാ വഖിനാ അദാബന്നാർ.","translation":"അല്ലാഹുവേ, നീ ഞങ്ങൾക്ക് നൽകിയതിൽ ഞങ്ങളെ നീ അനുഗ്രഹിക്കുകയും നരകശിക്ഷയിൽ നിന്ന് ഞങ്ങളെ കാത്തുരക്ഷിക്കുകയും ചെയ്യേണമേ."},{"id":9,"category":"After Eating","title":"Dua After Eating","arabic":"الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ","transliteration":"അൽഹംദു ലില്ലാഹില്ലദീ അത്വ്അമനാ വ സഖാനാ വ ജഅലനാ മുസ്ലിമീൻ.","translation":"നമ്മെ പോഷിപ്പിക്കുകയും കുടിക്കാൻ നൽകുകയും മുസ്‌ലിംകളാക്കുകയും ചെയ്ത അല്ലാഹുവിനാണ് എല്ലാ സ്തുതിയും."},{"id":10,"category":"Enter Mosque","title":"Dua for Entering the Mosque","arabic":"اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ","transliteration":"അല്ലാഹുമ്മഫ്തഹ്‌ലീ അബ്‌വാബ റഹ്മതിക.","translation":"അല്ലാഹുവേ, നിൻ്റെ കാരുണ്യത്തിൻ്റെ വാതിലുകൾ എനിക്കായി തുറക്കേണമേ."},{"id":11,"category":"Exit Mosque","title":"Dua for Exiting the Mosque","arabic":"اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ","transliteration":"അല്ലാഹുമ്മ ഇന്നീ അസ്അലുക മിൻ ഫള്‌ലിക്.","translation":"അല്ലാഹുവേ, ഞാൻ നിന്നോട് നിൻ്റെ ഔദാര്യം ചോദിക്കുന്നു."},{"id":12,"category":"After Adhan","title":"Dua After Adhan","arabic":"اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ، وَالصَّلَاةِ الْقَائِمَةِ، آتِ مُحَمَّدًا الْوَسِيلَةَ وَالْفَضِيلَةَ، وَابْعَثْهُ مَقَامًا مَحْمُودًا الَّذِي وَعَدْتَهُ، إِنَّكَ لَا تُخْلِفُ الْمِيعَادَ","transliteration":"അല്ലാഹുമ്മ റബ്ബ ഹാദിഹി ദ്ദഅവതിത്താമ്മ, വസ്സ്വലാത്തിൽ ഖാഇമ, ആത്തി മുഹമ്മദനിൽ വസ്വീലത്ത വൽ ഫളീല, വബ്അസ്ഹൂ മഖാമൻ മഹ്മൂദനില്ലദീ വഅത്തഹൂ, ഇന്നകലാ തുഹ്ലിഫുൽ മീആദ്.","translation":"അല്ലാഹുവേ, ഈ സമ്പൂർണ്ണമായ ആഹ്വാനത്തിൻ്റെയും സ്ഥാപിതമായ പ്രാർത്ഥനയുടെയും രക്ഷിതാവേ, മുഹമ്മദിന് മാദ്ധ്യസ്ഥതയും ശ്രേഷ്ഠതയും നൽകുകയും നീ അവനു വാഗ്ദത്തം ചെയ്ത വാഴ്ത്തപ്പെട്ട സ്റ്റേഷനിലേക്ക് അവനെ ഉയർത്തുകയും ചെയ്യുക. തീർച്ചയായും നീ നിൻ്റെ വാഗ്ദാനം ലംഘിക്കുന്നില്ല."},{"id":13,"category":"After Wudu","title":"Dua After Wudu","arabic":"أَشْهَدُ أَنْ لا إِلَـهَ إِلاّ اللهُ وَحْدَهُ لا شَريـكَ لَـهُ وَأَشْهَدُ أَنَّ مُحَمّـداً عَبْـدُهُ وَرَسـولُـه,اللّهُـمَّ اجْعَلنـي مِنَ التَّـوّابينَ وَاجْعَـلْني مِنَ المتَطَهّـرين,سُبْحـانَكَ اللّهُـمَّ وَبِحَمدِك أَشْهَـدُ أَنْ لا إِلهَ إِلاّ أَنْتَ أَسْتَغْفِرُكَ وَأَتوبُ إِلَـيْك","transliteration":"അശ്ഹദു അൻലാഇലാഹ ഇല്ലല്ലാഹു വഹ്ദഹൂ ലാ ശരീക്കലഹൂ, വ അശ്ഹദു അന്ന മുഹമ്മദൻ അബ്ദുഹൂ വറസൂലുഹൂ, അല്ലാഹുമ്മജ്അൽനീ മിനത്തവ്വാബീന വജ്അൽനീ മിനൽ മുതത്വഹ്ഹിരീൻ, സുബ്ഹാനകല്ലാഹുമ്മ വബിഹംദിക അശ്ഹദു അൻലാഇലാഹ ഇല്ലാ അൻത അസ്തഗ്ഫിറുക വ അതൂബു ഇലയ്ക്ക്.","translation":"പങ്കാളികളില്ലാതെ ഏകനായ അല്ലാഹുവല്ലാതെ ഒരു ദൈവവുമില്ലെന്ന് ഞാൻ സാക്ഷ്യം വഹിക്കുന്നു, മുഹമ്മദ് അവൻ്റെ ദാസനും ദൂതനുമാണെന്ന് ഞാൻ സാക്ഷ്യം വഹിക്കുന്നു. അല്ലാഹുവേ, നിരന്തരം പശ്ചാത്തപിക്കുന്നവരുടെ കൂട്ടത്തിൽ എന്നെയും സ്വയം ശുദ്ധീകരിക്കുന്നവരുടെ കൂട്ടത്തിലും എന്നെ ആക്കണമേ. അല്ലാഹുവേ, നിനക്കു മഹത്വം, നീയല്ലാതെ ഒരു ദൈവവുമില്ലെന്ന് നിൻ്റെ സ്തുതിയോടെ ഞാൻ സാക്ഷ്യം വഹിക്കുന്നു. ഞാൻ നിന്നോട് ക്ഷമ ചോദിക്കുകയും പശ്ചാത്താപത്തോടെ നിന്നിലേക്ക് തിരിയുകയും ചെയ്യുന്നു."},{"id":14,"category":"Stress","title":"Dua for Stress Relief","arabic":"اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحُزْنِ وَالْعَجْزِ وَالْكَسَلِ وَالْجُبْنِ وَالْبُخْلِ وَغَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ","transliteration":"അല്ലാഹുമ്മ ഇന്നീ അഊദുബിക മിനൽ ഹമ്മി ഹസ്ൻ, വൽ അജ്സി വൽ കസ്ൽ, വൽ ജുബ്നി വൽ ബുഹ്ൽ, വഗലബത്തിദ്ദയ്നി വഖഹ്‌രിര്രിജാൽ.","translation":"അല്ലാഹുവേ, ആകുലതകളിൽ നിന്നും ദുഃഖങ്ങളിൽ നിന്നും നിസ്സഹായതയിൽ നിന്നും അലസതയിൽ നിന്നും ഭീരുത്വത്തിൽ നിന്നും പിശുക്കിൽ നിന്നും കടബാധ്യതയിൽ നിന്നും മനുഷ്യരുടെ അടിച്ചമർത്തലിൽ നിന്നും ഞാൻ നിന്നോട് അഭയം തേടുന്നു."},{"id":15,"category":"Marriage","title":"Dua for Marriage Blessing","arabic":"بَارَكَ اللَّهُ لَكُمَا وَبَارَكَ عَلَيْكُمَا وَجَمَعَ بَيْنَكُمَا فِي خَيْرٍ","transliteration":"ബാറകല്ലാഹു ലകുമാ വബാറക അലയ്കുമാ വജമഅ ബയ്നകുമാ ഫീ ഹയ്ർ.","translation":"അല്ലാഹു നിങ്ങളെ അനുഗ്രഹിക്കുകയും അവൻ്റെ അനുഗ്രഹങ്ങൾ നിങ്ങളുടെ മേൽ വർഷിക്കുകയും ചെയ്യട്ടെ."},{"id":16,"category":"Patience","title":"Dua for Patience","arabic":"رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ","transliteration":"റബ്ബനാ അഫ്‌രിഗ് അലയ്നാ സ്വബ്റൻ വസബ്ബിത്ത് അഖ്ദാമനാ വൻസ്വുർനാ അലൽ ഖൗമിൽ കാഫിരീൻ.","translation":"ഞങ്ങളുടെ രക്ഷിതാവേ, ഞങ്ങളുടെ മേൽ ക്ഷമ ചൊരിയുകയും ഞങ്ങളുടെ പാദങ്ങൾ ഉറപ്പിക്കുകയും സത്യനിഷേധികളായ ജനങ്ങളുടെ മേൽ ഞങ്ങൾക്ക് വിജയം നൽകുകയും ചെയ്യേണമേ."}]

DuaModel duaModelFromJson(String str) => DuaModel.fromJson(json.decode(str));
String duaModelToJson(DuaModel data) => json.encode(data.toJson());

class DuaModel {
  DuaModel({
    bool? status,
    String? message,
    List<DuaData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  DuaModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DuaData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<DuaData>? _data;
  DuaModel copyWith({
    bool? status,
    String? message,
    List<DuaData>? data,
  }) =>
      DuaModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<DuaData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// category : "Morning"
/// title : "Morning Dua"
/// arabic : "اللّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ"
/// transliteration : "അല്ലാഹുമ്മ ബിക അസ്വ്ബഹ്‌നാ, വ ബിക അംസയ്‌നാ, വ ബിക നഹ്‌യാ, വ ബിക നമൂത്തു, വ ഇലയ്ക്കന്നുശൂർ."
/// translation : "അല്ലാഹുവേ, നിന്നിലൂടെ ഞങ്ങൾ പ്രഭാതം ആരംഭിക്കുന്നു, നിന്നിലൂടെ ഞങ്ങൾ വൈകുന്നേരം അവസാനിക്കുന്നു, നിന്നാൽ ഞങ്ങൾ ജീവിക്കുന്നു, നിന്നാൽ ഞങ്ങൾ മരിക്കുന്നു, നിന്നിലേക്കാണ് ഞങ്ങളുടെ മടക്കം."

DuaData dataFromJson(String str) => DuaData.fromJson(json.decode(str));
String dataToJson(DuaData data) => json.encode(data.toJson());

class DuaData {
  DuaData({
    num? id,
    String? category,
    String? title,
    String? arabic,
    String? transliteration,
    String? translation,
  }) {
    _id = id;
    _category = category;
    _title = title;
    _arabic = arabic;
    _transliteration = transliteration;
    _translation = translation;
  }

  DuaData.fromJson(dynamic json) {
    _id = json['id'];
    _category = json['category'];
    _title = json['title'];
    _arabic = json['arabic'];
    _transliteration = json['transliteration'];
    _translation = json['translation'];
  }
  num? _id;
  String? _category;
  String? _title;
  String? _arabic;
  String? _transliteration;
  String? _translation;
  DuaData copyWith({
    num? id,
    String? category,
    String? title,
    String? arabic,
    String? transliteration,
    String? translation,
  }) =>
      DuaData(
        id: id ?? _id,
        category: category ?? _category,
        title: title ?? _title,
        arabic: arabic ?? _arabic,
        transliteration: transliteration ?? _transliteration,
        translation: translation ?? _translation,
      );
  num? get id => _id;
  String? get category => _category;
  String? get title => _title;
  String? get arabic => _arabic;
  String? get transliteration => _transliteration;
  String? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category'] = _category;
    map['title'] = _title;
    map['arabic'] = _arabic;
    map['transliteration'] = _transliteration;
    map['translation'] = _translation;
    return map;
  }
}
