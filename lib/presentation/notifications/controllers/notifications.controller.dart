import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/common_response.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/core/interfaces/utility_services.dart';
import '../../../domain/listing/listing_repository.dart';
import '../../../domain/listing/listing_service.dart';
import '../../../domain/listing/models/GetNotificationsModel.dart';
import '../../../infrastructure/dal/services/storage_service.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/strings/app_strings.dart';

class NotificationsController extends GetxController {
  final StorageService storageService = StorageService();
  ListingService listingService = Get.find<ListingRepository>();

  List<NotificationsData> notificationList = [
    NotificationsData(
        id: 1,
        date: '02/12/2024',
        readStatus: false,
        notification:
            'ബദ്‌രീങ്ങളുടെ ആണ്ട് നേർച്ച  കയനി നൂർ ജുമാ മസ്ജിദിൽ വെച്ചു 05/12/2024 വ്യാഴാഴ്ച്ച രാവിലെ സുബ്ഹി നിസ്കാരാന്തരം നടത്തപ്പെടുന്നതാണ്. അന്നേ ദിവസം രാവിലെ 10 മണിക്ക് അന്നദാനം ഉണ്ടായിരിക്കുന്നതാണ്. എല്ലാവരും നേര്ച്ച തുകയും പാത്രവും ആയി കൃത്യ സമയത്തു തന്നെ എത്തിച്ചേരണം എന്ന് അപേക്ഷിക്കുന്നു.',
        postedBy: 'President'),
    NotificationsData(
        id: 2,
        date: '02/12/2024',
        readStatus: false,
        notification:
            'ഇന്നാ ലില്ലാഹി വ ഇന്നാ ഇലൈഹി റാജിഊൻ. കൂളിക്കടവ് താമസിക്കുന്ന വലിയപറമ്പിൽ കദീജ (72 വയസ്സ് ) എന്നവർ അൽപ്പ സമയം മുമ്ബ് മരണപ്പെട്ട വിവരം വളരെ സങ്കടത്തോടെ അറിയിക്കുന്നു. മയ്യിത്തു നിസ്കാരം ഇന്ന് വൈകുന്നേരം അസർ നിസ്‌കാരാനന്തരം നടക്കുന്നാതാണ്.',
        postedBy: 'Treasurer'),
    NotificationsData(
        id: 3,
        date: '01/12/2024',
        readStatus: true,
        notification: 'Testing notification',
        postedBy: 'Secretary'),
    NotificationsData(
        id: 4,
        date: '30/11/2024',
        readStatus: true,
        notification:
            'This is a sample notification. Please check the notification by opening it for the sake of your knowledge. Otherwise you may miss the important information about the masjid.',
        postedBy: 'Secretary'),
    NotificationsData(
        id: 1,
        date: '02/12/2024',
        readStatus: true,
        notification:
            'ബദ്‌രീങ്ങളുടെ ആണ്ട് നേർച്ച  കയനി നൂർ ജുമാ മസ്ജിദിൽ വെച്ചു 05/12/2024 വ്യാഴാഴ്ച്ച രാവിലെ സുബ്ഹി നിസ്കാരാന്തരം നടത്തപ്പെടുന്നതാണ്. അന്നേ ദിവസം രാവിലെ 10 മണിക്ക് അന്നദാനം ഉണ്ടായിരിക്കുന്നതാണ്. എല്ലാവരും നേര്ച്ച തുകയും പാത്രവും ആയി കൃത്യ സമയത്തു തന്നെ എത്തിച്ചേരണം എന്ന് അപേക്ഷിക്കുന്നു.',
        postedBy: 'President'),
    NotificationsData(
        id: 2,
        date: '02/12/2024',
        readStatus: true,
        notification:
            'ഇന്നാ ലില്ലാഹി വ ഇന്നാ ഇലൈഹി റാജിഊൻ. കൂളിക്കടവ് താമസിക്കുന്ന വലിയപറമ്പിൽ കദീജ (72 വയസ്സ് ) എന്നവർ അൽപ്പ സമയം മുമ്ബ് മരണപ്പെട്ട വിവരം വളരെ സങ്കടത്തോടെ അറിയിക്കുന്നു. മയ്യിത്തു നിസ്കാരം ഇന്ന് വൈകുന്നേരം അസർ നിസ്‌കാരാനന്തരം നടക്കുന്നാതാണ്.',
        postedBy: 'Treasurer'),
    NotificationsData(
        id: 3,
        date: '01/12/2024',
        readStatus: true,
        notification:
            'കോൺസെക്വാറ്റ് ഉല്ലാംകോ കോൺസെക്റ്റെത്ർ ലാബോറിസ് സിറ്റ് കോൺസെക്റ്റെത്ർ കോൺസെക്വാറ്റ് ആനിം എനിം ആലിക്വാ എനിം നോസ്ത്രുഡ് ക്വിസ് നോൺ ഒക്കേകാറ്റ് കോൺസെക്വാറ്റ് എറ്റ് കുൽപ്പ നോൺ എസ്റ്റ് പാരിയാതൂർ ആനിം എലിറ്റ് കോൺസെക്റ്റെത്ർ മാഗ്നാ റെപ്രഹെൻഡെറിറ്റ് എലിറ്റ് നല്ല കുൽപ്പ ലബോറെ മൊല്ലിറ്റ് ഡോളോർ ഇൻസിഡിഡുന്റ് വെനിയം ഇൻ ഓഫീഷ്യ വെലിറ്റ് ഉട്ട് എസ്റ്റ് ഡോളോരെ ടെംപോർ ഐഡി ക്വിസ് ഇൻ ഇറൂറെ ലബോറെ നോസ്ത്രുഡ് അഡിപിസിസിംഗ് വൊളുപ്‌ടേറ്റ് എസ്സെ അലിക്വിപ്പ് ആഡ് എക്സെപ്റ്റെർ സിന്‍റ് ഡ്യൂയിസ് ആലിക്വാ ഉട്ട് ഉട്ട് മിനിം എക്സ് ഡ്യൂയിസ് ഈ വെനിയം എസ്സെ എറ്റ് കൊമ്മോഡോ ഓഫീഷ്യ പാരിയാതൂർ ടെംപോർ എക്സെർസിറ്റേഷൻ എക്സെർസിറ്റേഷൻ പ്രൊഇഡന്റ് ക്വിസ് ലോറം ഇറൂറെ ടെംപോർ പ്രൊഇഡന്റ് ഇപ്സം മിനിം പാരിയാതൂർ ഡോളോർ ലബോറും ഫ്യൂജിറ്റ് എയ്യൂസ്മോഡ് ഇൻ ആലിക്വാ എയു വൊളുപ്‌ടേറ്റ് ക്വിസ് കോൺസെക്വാറ്റ് ഡിസെറുന്റ് എയ്യൂസ്മോഡ് വൊളുപ്‌ടേറ്റ് ആലിക്വാ എനിം നല്ല ഡോ റെപ്രഹെൻഡെറിറ്റ് ഫ്യൂജിറ്റ് സുന്ത് എസ്സെ ക്വിസ് ലബോറും ഈ അലിക്വിപ്പ് ഐഡി എയു നിസി ഡോ ഡ്യൂയിസ് ലോറം ഐഡി ലബോറും അലിക്വിപ്പ് ഒക്കേകാറ്റ് കൊമ്മോഡോ ടെംപോർ ഉട്ട് എസ്റ്റ് വൊളുപ്‌ടേറ്റ് റെപ്രഹെൻഡെറിറ്റ് ക്വി കോൺസെക്റ്റെത്ർ ഇൻസിഡിഡുന്റ് എലിറ്റ് ലബോറെ ആലിക്വാ അഡിപിസിസിംഗ് ഡ്യൂയിസ് സിറ്റ് ലബോറും ഉല്ലാംകോ കുൽപ്പ ചില്ലം എക്സ് എലിറ്റ് ഡ്യൂയിസ് ലബോറും എക്സെർസിറ്റേഷൻ എയു പ്രൊഇഡന്റ് എക്സ് ഫ്യൂജിറ്റ് ക്വി റെപ്രഹെൻഡെറിറ്റ് ടെംപോർ ഇൻസിഡിഡുന്റ് മിനിം എലിറ്റ് വെനിയം ഓഫീഷ്യ ഇൻ ചില്ലം ഡോ ഫ്യൂജിറ്റ് ഉല്ലാംകോ വെലിറ്റ് ഐഡി പ്രൊഇഡന്റ് എനിം നോസ്ത്രുഡ് ഇറൂറെ വെനിയം സുന്ത് ക്വിസ് വെനിയം ആനിം കുൽപ്പ മാഗ്നാ ക്വിസ് അമെറ്റ് എറ്റ് ഡോളോർ എലിറ്റ് ആഡ് ഐഡി ഡ്യൂയിസ് എക്സെപ്റ്റെർ ക്യൂപിഡാറ്റ് നോൺ ഡോളോരെ അമെറ്റ് ഡോളോരെ വെനിയം മൊല്ലിറ്റ് ഇറൂറെ കോൺസെക്വാറ്റ് കോൺസെക്വാറ്റ് എറ്റ് ഐഡി ക്വി ഇപ്സം നിസി സിന്‍റ് മൊല്ലിറ്റ് പാരിയാതൂർ ഓട്ടെ എക്സെപ്റ്റെർ കോൺസെക്റ്റെത്ർ ഇൻസിഡിഡുന്റ് എനിം റെപ്രഹെൻഡെറിറ്റ് ഡ്യൂയിസ് അമെറ്റ് കോൺസെക്വാറ്റ് സുന്ത് മിനിം ലബോറെ എക്സെപ്റ്റെർ ഡോ സിന്‍റ് ഫ്യൂജിറ്റ് എസ്റ്റ് സിറ്റ് ഇറൂറെ ലോറം ഡോ ക്യൂപിഡാറ്റ് ഡിസെറുന്റ് എസ്സെ അമെറ്റ് ഇപ്സം ഉല്ലാംകോ എയ്യൂസ്മോഡ് ക്വിസ് ഓഫീഷ്യ ഡിസെറുന്റ് ടെംപോർ പ്രൊഇഡന്റ് എക്സ് ക്വി ടെംപോർ കുൽപ്പ റെപ്രഹെൻഡെറിറ്റ് അഡിപിസിസിംഗ് എയു ആഡ് ലോറം ഡോളോരെ സിന്‍റ് ലബോറെ ആലിക്വാ ആലിക്വാ അഡിപിസിസിംഗ് ക്യൂപിഡാറ്റ് കൊമ്മോഡോ വൊളുപ്‌ടേറ്റ് ഓട്ടെ ഓഫീഷ്യ ചില്ലം വൊളുപ്‌ടേറ്റ് ആനിം ലബോറും ഇൻ പ്രൊഇഡന്റ് കോൺസെക്വാറ്റ് അലിക്വിപ്പ് ഇൻസിഡിഡുന്റ് എയു കുൽപ്പ ഇറൂറെ മാഗ്നാ ആലിക്വാ എസ്റ്റ് ലോറം ഓട്ടെ ടെംപോർ നോസ്ത്രുഡ് മൊല്ലിറ്റ് ടെംപോർ ക്വി എയു ഡോളോർ എക്സെർസിറ്റേഷൻ വൊളുപ്‌ടേറ്റ് ഐഡി എസ്റ്റ് എക്സെപ്റ്റെർ ഡോളോർ എസ്സെ ടെംപോർ ക്യൂപിഡാറ്റ് എസ്സെ കൊമ്മോഡോ സിറ്റ് ലബോറും സിന്‍റ് കോൺസെക്വാറ്റ് അമെറ്റ് ഡോ അഡിപിസിസിംഗ് ക്യൂപിഡാറ്റ് ആഡ് ക്വിസ് നല്ല എറ്റ് ഒക്കേകാറ്റ് മിനിം ഉട്ട് കൊമ്മോഡോ ആനിം ആനിം സിന്‍റ് വെനിയം ആനിം ഇറൂറെ ഓഫീഷ്യ ഓട്ടെ വെനിയം എലിറ്റ് സിന്‍റ് ഡോ എയ്യൂസ്മോഡ് എറ്റ് ആനിം വൊളുപ്‌ടേറ്റ് നിസി നല്ല ഡ്യൂയിസ് ഡ്യൂയിസ് അലിക്വിപ്പ് കുൽപ്പ അമെറ്റ് ക്വി ഉല്ലാംകോ ഇൻസിഡിഡുന്റ് ഡോളോരെ സുന്ത് ക്യൂപിഡാറ്റ് ചില്ലം നോൺ ടെംപോർ അലിക്വിപ്പ് ക്വിസ് സിന്‍റ് എനിം എയ്യൂസ്മോഡ് എറ്റ് മാഗ്നാ ഇൻസിഡിഡുന്റ് എക്സെർസിറ്റേഷൻ എക്സെർസിറ്റേഷൻ സിന്‍റ് ഇപ്സം എക്സ് നല്ല ഡോളോർ എസ്സെ ഓഫീഷ്യ ഡോളോർ ഫ്യൂജിറ്റ് പാരിയാതൂർ നോസ്ത്രുഡ് സിന്‍റ് എയു ഓട്ടെ സുന്ത് കൊമ്മോഡോ ക്യൂപിഡാറ്റ് ക്വി നല്ല നല്ല ആഡ് ടെംപോർ ആനിം ഒക്കേകാറ്റ് മാഗ്നാ ലോറം പ്രൊഇഡന്റ് എലിറ്റ് ഡോളോരെ ഇറൂറെ എസ്റ്റ് എയു എസ്റ്റ് ആലിക്വാ സുന്ത് എസ്സെ കോൺസെക്വാറ്റ് നിസി സുന്ത് എലിറ്റ് ക്വി ക്വി ആനിം എസ്സെ എനിം എലിറ്റ് ചില്ലം എക്സെർസിറ്റേഷൻ എസ്സെ നോസ്ത്രുഡ് ആനിം മൊല്ലിറ്റ് ക്വി അലിക്വിപ്പ് ഓഫീഷ്യ മാഗ്നാ എക്സെപ്റ്റെർ ആലിക്വാ എക്സെർസിറ്റേഷൻ ഉട്ട് ക്വിസ് ഓട്ടെ റെപ്രഹെൻഡെറിറ്റ് ഡിസെറുന്റ് ഇൻസിഡിഡുന്റ് വെനിയം കുൽപ്പ വെലിറ്റ് മിനിം ഇറൂറെ ഓട്ടെ നിസി ഉല്ലാംകോ മാഗ്നാ ലബോറും ഡോളോർ ഓട്ടെ വൊളുപ്‌ടേറ്റ് ഇറൂറെ എക്സെപ്റ്റെർ ലോറം സിന്‍റ് അമെറ്റ് കോൺസെക്വാറ്റ് ആലിക്വാ ഫ്യൂജിറ്റ് സുന്ത് എറ്റ് ചില്ലം കുൽപ്പ ഈ ഓട്ടെ എക്സ് എയു കുൽപ്പ ക്വിസ് എയു വൊളുപ്‌ടേറ്റ് എറ്റ് കൊമ്മോഡോ എനിം എയ്യൂസ്മോഡ് മിനിം ആനിം കോൺസെക്റ്റെത്ർ ക്വിസ് ലാബോറിസ് ലബോറെ ക്വിസ് ക്യൂപിഡാറ്റ് ഐഡി അമെറ്റ് നോൺ ക്വി നോൺ ഡോ കുൽപ്പ ലാബോറിസ് ആലിക്വാ പാരിയാതൂർ ഡോ എനിം നല്ല മാഗ്നാ ഇപ്സം എയു കോൺസെക്വാറ്റ് എയ്യൂസ്മോഡ് നോസ്ത്രുഡ് ലബോറെ കുൽപ്പ മാഗ്നാ ഒക്കേകാറ്റ് അലിക്വിപ്പ് ചില്ലം ക്വിസ് ഒക്കേകാറ്റ് വെനിയം ഒക്കേകാറ്റ് ഇറൂറെ ഡോളോർ ഡോളോരെ ക്യൂപിഡാറ്റ് ഡിസെറുന്റ് എസ്സെ ടെംപോർ ഓഫീഷ്യ കൊമ്മോഡോ കോൺസെക്റ്റെത്ർ ക്വിസ് സുന്ത് ഇറൂറെ എക്സെർസിറ്റേഷൻ ഐഡി ഇറൂറെ മൊല്ലിറ്റ് ഡ്യൂയിസ് അമെറ്റ് എക്സ് ക്വി നോൺ ചില്ലം പാരിയാതൂർ സിന്‍റ് ഓട്ടെ വെനിയം സിറ്റ് ആഡ് പ്രൊഇഡന്റ് ആലിക്വാ സിറ്റ് പാരിയാതൂർ ലബോറെ കൊമ്മോഡോ നോസ്ത്രുഡ് ഓട്ടെ ഡ്യൂയിസ് ആലിക്വാ ഇപ്സം ഡോളോരെ റെപ്രഹെൻഡെറിറ്റ് കോൺസെക്റ്റെത്ർ ഉല്ലാംകോ ഡ്യൂയിസ് മിനിം എനിം ഇൻ അമെറ്റ് ഫ്യൂജിറ്റ് ഇൻസിഡിഡുന്റ് സിന്‍റ് ഈ എസ്സെ ക്യൂപിഡാറ്റ് സുന്ത് ഇപ്സം സിന്‍റ് അഡിപിസിസിംഗ് ലാബോറിസ് എയു മാഗ്നാ വെലിറ്റ് ലാബോറിസ് എക്സെപ്റ്റെർ ഐഡി സുന്ത് അഡിപിസിസിംഗ് കുൽപ്പ നോൺ സിറ്റ് വെനിയം കോൺസെക്റ്റെത്ർ എനിം ഈ എസ്റ്റ് ഇൻ എസ്സെ എക്സെപ്റ്റെർ എക്സ് ഡോ ഓട്ടെ ഡോ കുൽപ്പ വൊളുപ്‌ടേറ്റ് എറ്റ് ലബോറെ മിനിം എയു ഉല്ലാംകോ ഡോ നല്ല എക്സെർസിറ്റേഷൻ പ്രൊഇഡന്റ് അലിക്വിപ്പ് നല്ല എക്സെപ്റ്റെർ എക്സെർസിറ്റേഷൻ ആലിക്വാ ക്യൂപിഡാറ്റ് ക്വി പ്രൊഇഡന്റ് എസ്സെ റെപ്രഹെൻഡെറിറ്റ് ക്വി ഉട്ട് ഡ്യൂയിസ് ലോറം ഇൻ എക്സ് അലിക്വിപ്പ് ഡോ സുന്ത് എയു ഇൻ സുന്ത് ലബോറും എക്സെർസിറ്റേഷൻ നല്ല ആലിക്വാ മിനിം ഡോളോർ ഇൻ ചില്ലം ലാബോറിസ് എറ്റ് ക്വിസ് മാഗ്നാ ക്യൂപിഡാറ്റ് ഉട്ട് വെലിറ്റ് കോൺസെക്റ്റെത്ർ ഡ്യൂയിസ് കോൺസെക്വാറ്റ് പാരിയാതൂർ സിറ്റ് ഉല്ലാംകോ ഡ്യൂയിസ് ക്വി ഇപ്സം ആഡ് കുൽപ്പ മൊല്ലിറ്റ് സിന്‍റ് കൊമ്മോഡോ ആഡ് വെലിറ്റ് എയ്യൂസ്മോഡ് എക്സെർസിറ്റേഷൻ എയു ഡോളോരെ സിറ്റ് മാഗ്നാ സിന്‍റ് പാരിയാതൂർ എനിം ഡോ സിന്‍റ് നോൺ എസ്റ്റ് ക്യൂപിഡാറ്റ് സുന്ത് മാഗ്നാ നോൺ നിസി നിസി അമെറ്റ് അമെറ്റ് ലബോറും സുന്ത് ആലിക്വാ അലിക്വിപ്പ് ഇപ്സം ഡോളോർ വൊളുപ്‌ടേറ്റ് സിറ്റ് ക്യൂപിഡാറ്റ് അമെറ്റ് ആനിം എക്സെപ്റ്റെർ ഒക്കേകാറ്റ് എക്സ് ഇറൂറെ ഓട്ടെ എയു ഫ്യൂജിറ്റ് ആനിം സിറ്റ് ലാബോറിസ് ലാബോറിസ് ഒക്കേകാറ്റ് എക്സെർസിറ്റേഷൻ ചില്ലം ഐഡി ഓട്ടെ എയു സിന്‍റ് ക്യൂപിഡാറ്റ് ക്യൂപിഡാറ്റ് ഡോളോരെ ഡ്യൂയിസ് ഒക്കേകാറ്റ് ലോറം എലിറ്റ് ഇറൂറെ എനിം ഡിസെറുന്റ് ഡ്യൂയിസ് സിന്‍റ് പ്രൊഇഡന്റ് ഡോളോരെ ചില്ലം എസ്സെ ഡോളോർ കോൺസെക്വാറ്റ് എക്സെർസിറ്റേഷൻ അമെറ്റ് ആലിക്വാ സിറ്റ് മിനിം ആഡ് ഡോളോർ എക്സ് ഡോളോരെ കുൽപ്പ കോൺസെക്റ്റെത്ർ സുന്ത് കുൽപ്പ അഡിപിസിസിംഗ് അലിക്വിപ്പ് എനിം അഡിപിസിസിംഗ് ആഡ് പാരിയാതൂർ ഉട്ട് ആഡ് കോൺസെക്വാറ്റ് എക്സെർസിറ്റേഷൻ അമെറ്റ് ആനിം നിസി ഐഡി ക്വിസ് എക്സെപ്റ്റെർ മാഗ്നാ ടെംപോർ ഐഡി എസ്സെ പാരിയാതൂർ ചില്ലം ആലിക്വാ ഫ്യൂജിറ്റ് കൊമ്മോഡോ ആഡ് എസ്സെ ഉല്ലാംകോ റെപ്രഹെൻഡെറിറ്റ് എനിം മൊല്ലിറ്റ് ഡ്യൂയിസ് ലാബോറിസ് സിന്‍റ് കോൺസെക്വാറ്റ് എനിം ഡിസെറുന്റ് റെപ്രഹെൻഡെറിറ്റ് ക്വിസ് ഡോളോർ എസ്സെ നോസ്ത്രുഡ് മിനിം എസ്റ്റ് ഈ ഉട്ട് കോൺസെക്റ്റെത്ർ നിസി എക്സ് ക്വിസ് ക്വിസ് കോൺസെക്വാറ്റ് റെപ്രഹെൻഡെറിറ്റ് ഇപ്സം കോൺസെക്റ്റെത്ർ എസ്സെ റെപ്രഹെൻഡെറിറ്റ് അഡിപിസിസിംഗ് റെപ്രഹെൻഡെറിറ്റ് കോൺസെക്വാറ്റ് എസ്റ്റ് ക്യൂപിഡാറ്റ് ആഡ് ഉല്ലാംകോ ഇറൂറെ ഡോളോർ ഇൻ എക്സെപ്റ്റെർ ലബോറും മൊല്ലിറ്റ് ക്യൂപിഡാറ്റ് എക്സെർസിറ്റേഷൻ ചില്ലം കൊമ്മോഡോ സുന്ത് ഇറൂറെ ഡിസെറുന്റ് എറ്റ് സുന്ത് ഇറൂറെ ലബോറും കോൺസെക്റ്റെത്ർ പ്രൊഇഡന്റ് എയ്യൂസ്മോഡ് ഇൻസിഡിഡുന്റ് മാഗ്നാ ലബോറെ ലബോറും മാഗ്നാ ഇറൂറെ ഡിസെറുന്റ്',
        postedBy: 'Secretary'),
    NotificationsData(
        id: 4,
        date: '30/11/2024',
        readStatus: true,
        notification:
            'This is a sample notification. Please check the notification by opening it for the sake of your knowledge. Otherwise you may miss the important information about the masjid.',
        postedBy: 'Secretary'),
    NotificationsData(
        id: 1,
        date: '02/12/2024',
        readStatus: true,
        notification:
            'ബദ്‌രീങ്ങളുടെ ആണ്ട് നേർച്ച  കയനി നൂർ ജുമാ മസ്ജിദിൽ വെച്ചു 05/12/2024 വ്യാഴാഴ്ച്ച രാവിലെ സുബ്ഹി നിസ്കാരാന്തരം നടത്തപ്പെടുന്നതാണ്. അന്നേ ദിവസം രാവിലെ 10 മണിക്ക് അന്നദാനം ഉണ്ടായിരിക്കുന്നതാണ്. എല്ലാവരും നേര്ച്ച തുകയും പാത്രവും ആയി കൃത്യ സമയത്തു തന്നെ എത്തിച്ചേരണം എന്ന് അപേക്ഷിക്കുന്നു.',
        postedBy: 'President'),
    NotificationsData(
        id: 2,
        date: '02/12/2024',
        readStatus: true,
        notification:
            'ഇന്നാ ലില്ലാഹി വ ഇന്നാ ഇലൈഹി റാജിഊൻ. കൂളിക്കടവ് താമസിക്കുന്ന വലിയപറമ്പിൽ കദീജ (72 വയസ്സ് ) എന്നവർ അൽപ്പ സമയം മുമ്ബ് മരണപ്പെട്ട വിവരം വളരെ സങ്കടത്തോടെ അറിയിക്കുന്നു. മയ്യിത്തു നിസ്കാരം ഇന്ന് വൈകുന്നേരം അസർ നിസ്‌കാരാനന്തരം നടക്കുന്നാതാണ്.',
        postedBy: 'Treasurer'),
    NotificationsData(
        id: 3,
        date: '01/12/2024',
        readStatus: true,
        notification: 'Testing notification',
        postedBy: 'Secretary'),
    NotificationsData(
        id: 4,
        date: '30/11/2024',
        readStatus: true,
        notification:
            'This is a sample notification. Please check the notification by opening it for the sake of your knowledge. Otherwise you may miss the important information about the masjid.',
        postedBy: 'Secretary'),
  ];

  //RxList<NotificationsData> notificationList = RxList([]);
  RxBool isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getNotifications();
  }

  getNotifications() async {
    isLoading.value = true;
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        GetNotificationsModel response = await listingService
            .getNotifications(storageService.getToken() ?? '');
        if (response.status == true) {
          notificationList = response.data!;
        } else {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.error);
        }
      } catch (e) {
        showToast(
            title: AppStrings.somethingWentWrong,
            type: ToastificationType.error);
      } finally {
        isLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isLoading.value = false;
    }
  }

  updateNotification(int index) async {
    var isConnectedToInternet = await isInternetAvailable();
    if (isConnectedToInternet) {
      try {
        CommonResponse response = await listingService.updateNotification(
            storageService.getToken() ?? '',
            {'id': notificationList[index].id});
        if (response.status == true) {
          Get.toNamed(Routes.VIEW_NOTIFICATION,
              arguments: notificationList[index]);
        } else {
          showToast(
              title: response.message.toString(),
              type: ToastificationType.error);
        }
      } catch (e) {
        showToast(
            title: AppStrings.somethingWentWrong,
            type: ToastificationType.error);
      } finally {
        isLoading.value = false;
      }
    } else {
      showToast(
          title: AppStrings.noInternetConnection,
          type: ToastificationType.error);
      isLoading.value = false;
    }
  }
}
