// A map of currency codes to their full names.
const Map<String, String> currencyNames = {
  'USD': 'United States Dollar',
  'EUR': 'Euro',
  'JPY': 'Japanese Yen',
  'GBP': 'British Pound Sterling',
  'AUD': 'Australian Dollar',
  'CAD': 'Canadian Dollar',
  'CHF': 'Swiss Franc',
  'CNY': 'Chinese Yuan',
  'SEK': 'Swedish Krona',
  'NZD': 'New Zealand Dollar',
  'MXN': 'Mexican Peso',
  'SGD': 'Singapore Dollar',
  'HKD': 'Hong Kong Dollar',
  'NOK': 'Norwegian Krone',
  'KRW': 'South Korean Won',
  'TRY': 'Turkish Lira',
  'RUB': 'Russian Ruble',
  'INR': 'Indian Rupee',
  'BRL': 'Brazilian Real',
  'ZAR': 'South African Rand',
  'AED': 'United Arab Emirates Dirham',
  'AFN': 'Afghan Afghani',
  'ALL': 'Albanian Lek',
  'AMD': 'Armenian Dram',
  'ANG': 'Netherlands Antillean Guilder',
  'AOA': 'Angolan Kwanza',
  'ARS': 'Argentine Peso',
  'AWG': 'Aruban Florin',
  'AZN': 'Azerbaijani Manat',
  'BAM': 'Bosnia-Herzegovina Convertible Mark',
  'BBD': 'Barbadian Dollar',
  'BDT': 'Bangladeshi Taka',
  'BGN': 'Bulgarian Lev',
  'BHD': 'Bahraini Dinar',
  'BIF': 'Burundian Franc',
  'BMD': 'Bermudan Dollar',
  'BND': 'Brunei Dollar',
  'BOB': 'Bolivian Boliviano',
  'BSD': 'Bahamian Dollar',
  'BTN': 'Bhutanese Ngultrum',
  'BWP': 'Botswanan Pula',
  'BYN': 'Belarusian Ruble',
  'BZD': 'Belize Dollar',
  'CDF': 'Congolese Franc',
  'CLP': 'Chilean Peso',
  'COP': 'Colombian Peso',
  'CRC': 'Costa Rican Colón',
  'CUP': 'Cuban Peso',
  'CVE': 'Cape Verdean Escudo',
  'CZK': 'Czech Koruna',
  'DJF': 'Djiboutian Franc',
  'DKK': 'Danish Krone',
  'DOP': 'Dominican Peso',
  'DZD': 'Algerian Dinar',
  'EGP': 'Egyptian Pound',
  'ERN': 'Eritrean Nakfa',
  'ETB': 'Ethiopian Birr',
  'FJD': 'Fijian Dollar',
  'FKP': 'Falkland Islands Pound',
  'GEL': 'Georgian Lari',
  'GGP': 'Guernsey Pound',
  'GHS': 'Ghanaian Cedi',
  'GIP': 'Gibraltar Pound',
  'GMD': 'Gambian Dalasi',
  'GNF': 'Guinean Franc',
  'GTQ': 'Guatemalan Quetzal',
  'GYD': 'Guyanaese Dollar',
  'HNL': 'Honduran Lempira',
  'HRK': 'Croatian Kuna',
  'HTG': 'Haitian Gourde',
  'HUF': 'Hungarian Forint',
  'IDR': 'Indonesian Rupiah',
  'ILS': 'Israeli New Shekel',
  'IMP': 'Manx pound',
  'IQD': 'Iraqi Dinar',
  'IRR': 'Iranian Rial',
  'ISK': 'Icelandic Króna',
  'JEP': 'Jersey Pound',
  'JMD': 'Jamaican Dollar',
  'JOD': 'Jordanian Dinar',
  'KES': 'Kenyan Shilling',
  'KGS': 'Kyrgystani Som',
  'KHR': 'Cambodian Riel',
  'KMF': 'Comorian Franc',
  'KPW': 'North Korean Won',
  'KWD': 'Kuwaiti Dinar',
  'KYD': 'Cayman Islands Dollar',
  'KZT': 'Kazakhstani Tenge',
  'LAK': 'Laotian Kip',
  'LBP': 'Lebanese Pound',
  'LKR': 'Sri Lankan Rupee',
  'LRD': 'Liberian Dollar',
  'LSL': 'Lesotho Loti',
  'LYD': 'Libyan Dinar',
  'MAD': 'Moroccan Dirham',
  'MDL': 'Moldovan Leu',
  'MGA': 'Malagasy Ariary',
  'MKD': 'Macedonian Denar',
  'MMK': 'Myanma Kyat',
  'MNT': 'Mongolian Tugrik',
  'MOP': 'Macanese Pataca',
  'MRU': 'Mauritanian Ouguiya',
  'MUR': 'Mauritian Rupee',
  'MVR': 'Maldivian Rufiyaa',
  'MWK': 'Malawian Kwacha',
  'MYR': 'Malaysian Ringgit',
  'MZN': 'Mozambican Metical',
  'NAD': 'Namibian Dollar',
  'NGN': 'Nigerian Naira',
  'NIO': 'Nicaraguan Córdoba',
  'NPR': 'Nepalese Rupee',
  'OMR': 'Omani Rial',
  'PAB': 'Panamanian Balboa',
  'PEN': 'Peruvian Nuevo Sol',
  'PGK': 'Papua New Guinean Kina',
  'PHP': 'Philippine Peso',
  'PKR': 'Pakistani Rupee',
  'PLN': 'Polish Zloty',
  'PYG': 'Paraguayan Guarani',
  'QAR': 'Qatari Rial',
  'RON': 'Romanian Leu',
  'RSD': 'Serbian Dinar',
  'RWF': 'Rwandan Franc',
  'SAR': 'Saudi Riyal',
  'SBD': 'Solomon Islands Dollar',
  'SCR': 'Seychellois Rupee',
  'SDG': 'Sudanese Pound',
  'SHP': 'Saint Helena Pound',
  'SLL': 'Sierra Leonean Leone',
  'SOS': 'Somali Shilling',
  'SRD': 'Surinamese Dollar',
  'SSP': 'South Sudanese Pound',
  'STD': 'São Tomé and Príncipe Dobra',
  'SYP': 'Syrian Pound',
  'SZL': 'Swazi Lilangeni',
  'THB': 'Thai Baht',
  'TJS': 'Tajikistani Somoni',
  'TMT': 'Turkmenistani Manat',
  'TND': 'Tunisian Dinar',
  'TOP': 'Tongan Paʻanga',
  'TTD': 'Trinidad and Tobago Dollar',
  'TWD': 'New Taiwan Dollar',
  'TZS': 'Tanzanian Shilling',
  'UAH': 'Ukrainian Hryvnia',
  'UGX': 'Ugandan Shilling',
  'UYU': 'Uruguayan Peso',
  'UZS': 'Uzbekistan Som',
  'VES': 'Venezuelan Bolívar',
  'VND': 'Vietnamese Dong',
  'VUV': 'Vanuatu Vatu',
  'WST': 'Samoan Tala',
  'XAF': 'CFA Franc BEAC',
  'XCD': 'East Caribbean Dollar',
  'XDR': 'Special Drawing Rights',
  'XOF': 'CFA Franc BCEAO',
  'XPF': 'CFP Franc',
  'YER': 'Yemeni Rial',
  'ZMW': 'Zambian Kwacha',
  'ZWL': 'Zimbabwean Dollar',
  'BTC': 'Bitcoin',
  'ETH': 'Ethereum',
  'LTC': 'Litecoin',
  'XRP': 'Ripple',
  'BCH': 'Bitcoin Cash',
  'USDT': 'Tether',
  'USDC': 'USD Coin',
  'DAI': 'Dai',
  'BNB': 'Binance Coin',
  'SOL': 'Solana',
  'ADA': 'Cardano',
  'DOT': 'Polkadot',
  'AVAX': 'Avalanche',
  'SHIB': 'Shiba Inu',
  'MATIC': 'Polygon',
  'TRX': 'Tron',
  'ETC': 'Ethereum Classic',  

};

// Returns the currency symbol for a given currency code.
String getCurrencySymbol(String currencyCode) {
  switch (currencyCode) {
    case 'USD': return '\$';
    case 'EUR': return '€';
    case 'JPY': return '¥';
    case 'GBP': return '£';
    case 'AUD': return '\$';
    case 'CAD': return '\$';
    case 'CHF': return 'CHF';
    case 'CNY': return '¥';
    case 'SEK': return 'kr';
    case 'NZD': return '\$';
    case 'INR': return '₹';
    case 'BRL': return 'R\$';
    case 'RUB': return '₽';
    case 'ZAR': return 'R';
    case 'KRW': return '₩';
    case 'TRY': return '₺';
    case 'NGN': return '₦';
    case 'PHP': return '₱';
    case 'THB': return '฿';
    case 'VND': return '₫';
    case 'ILS': return '₪';
    case 'EGP': return '£';
    case 'SAR': return '﷼';
    case 'AED': return 'د.إ';
    case 'KWD': return 'د.ك';
    case 'QAR': return 'ر.ق';
    case 'OMR': return 'ر.ع.';
    case 'BDT': return '৳';
    case 'PKR': return '₨';
    case 'LKR': return '₨';
    case 'GHS': return '₵';
    case 'XAF': return 'FCFA';
    case 'XOF': return 'CFA';
    case 'XPF': return 'CFP';
    case 'HUF': return 'Ft';
    case 'CZK': return 'Kč';
    case 'PLN': return 'zł';
    case 'DKK': return 'kr';
    case 'NOK': return 'kr';
    case 'HRK': return 'kn';
    case 'RON': return 'lei';
    case 'BGN': return 'лв';
    case 'UAH': return '₴';
    case 'BYN': return 'Br';
    case 'KZT': return '₸';
    case 'GEL': return '₾';
    case 'AMD': return '֏';
    case 'AZN': return '₼';
    case 'MKD': return 'ден';
    case 'ALL': return 'L';
    case 'MDL': return 'L';
    case 'TJS': return 'ЅМ';
    case 'AFN': return '؋';
    case 'IQD': return 'ع.د';
    case 'SYP': return '£';
    case 'LBP': return '£';
    case 'JOD': return 'د.ا';
    case 'DZD': return 'دج';
    case 'MAD': return 'د.م.';
    case 'TND': return 'د.ت';
    case 'LYD': return 'ل.د';
    case 'MUR': return '₨';
    case 'MVR': return 'ރ.';
    case 'MZN': return 'MTn';
    case 'ZMW': return 'ZK';
    case 'XAU': return 'Au';
    case 'XAG': return 'Ag';
    case 'XPT': return 'Pt';
    case 'XPD': return 'Pd';
    case 'BTC': return '₿';
    case 'ETH': return 'Ξ';
    case 'LTC': return 'Ł';
    case 'XRP': return 'Ʀ';
    case 'BCH': return 'Ƀ';
    case 'USDT': return '₮';
    case 'USDC': return '\$';
    case 'DAI': return 'Đ';
    case 'BNB': return 'ⓑ';
    case 'SOL': return '◎';
    case 'ADA': return '₳';
    case 'DOT': return '●';
    case 'AVAX': return 'A';
    case 'SHIB': return '𐑖';  
    case 'MATIC': return 'M';
    case 'TRX': return 'T';
    case 'ETC': return 'Ξ';
    
    default: return currencyCode;
  }
}
