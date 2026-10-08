/*
  Freelancer items plugin v2 (2025-07-29)
  Original version by lennardf1989
  v2 Rewrite by grappigegovert
  v2.1 add bruce lee unlockables + add reset_for_merchants
  v2.2 add eminem unlockables + fix peacock version check + add only_on_button mode
  V2.3 add filur unlockables (by MLuka47)
  V2.4 add multiple unlockables (by MLuka47)
  V2.4.1 put localized names in comments + add sports entitlements for disruptor items
  v2.5 add snoop dogg + getaway pack
*/
const give_persistent_items = true;
const give_transient_items = true;
const reset_for_merchants = false;
const only_on_button = false;

const { log, LogLevel } = require("@peacockproject/core/loggingInterop");
const { contractRoutingRouter } = require("@peacockproject/core/contracts/contractRouting");
const { getCpd } = require("@peacockproject/core/evergreen");
const { getUserData } = require("@peacockproject/core/databaseHandler");
const { compare, PEACOCKVERSTRING } = require("@peacockproject/core/utils");
const { menuSystemDatabase } = require("@peacockproject/core/menus/menuSystem");

const itemsGroups = [
  {
    // snipers 1 (right-most wall)
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "1264f20b-b901-4d36-bc03-a9115709b531", // Jaeger 7 Lancer
      "081f8265-63db-4759-96a3-5186caf59f62", // Jaeger 7 Tuatara
      "370580fc-7fcf-47f8-b994-cebd279f69f9", // Jaeger 7
      "eedb7f84-896d-403b-905b-11b105e7ce35", // Jaeger 7 Covert
      "034ce4ab-b85a-4706-bdef-cba77f9b45f7", // Jaeger 7 Tiger
      "f301f605-007c-4fe1-aa99-a8cd2cae033f", // Sieger 300 Ghost
      "41ac4076-e197-4576-894b-499534fd37e8", // Sieger 300 Viper
      "907e0277-7806-42a4-b4b2-338cf8dd9391", // Sieger 300 Advanced
    ]
  },
  {
    // snipers 2 (2nd wall from right)
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "0f9608e9-6e42-49b9-b4cd-9aaebba8458f", // Hackl Leviathan Sniper Rifle Covert
      "7d64d9df-5d30-4e98-9af0-7562ee145d5c", // Sieger 300 Tactical
      "82642e14-c6d7-43b3-8b9c-396823a2859a", // Sieger 300
      "f5d0b800-bf37-41ff-bd19-4c04e3b69754", // Druzhina 34
      "f5e3a7ca-d0d3-421e-b341-b5ba46bc900f", // Druzhina 34 DTI
      "26605ee6-6e82-4a57-909f-76b91e7d93ed", // Druzhina 34 ICA Arctic
      "0e3dc26a-9eed-4aa1-b81e-d0c597b36737", // ICA Bartoli Woodsman Hunting Rifle Covert
      "87bf38ca-de63-4037-ae32-7817a42c7ced", // Bartoli Woodsman Hunting Rifle
    ]
  },
  {
    // pistols (3rd wall from right)
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "ff340698-bc83-479c-8917-16d99b39406c", // ICA19 Classicballer
      "2953e9ac-e25b-41ae-afbf-4a47f86c4f54", // Bartoli 75S
      "55ed7196-2303-4af6-9fa3-45b691134561", // Bartoli 75R
      "1e11fbea-cd51-48bf-8316-a050772d6135", // Hackl 9S
      "1cae7d71-55c8-401a-9dfb-cd0909c4f6ee", // Hackl 9R
      "304fd49f-0624-4691-8506-149a4b16808e", // HWK 21
      "494517eb-a6d1-4087-857a-37c8910703cf", // HWK 21 Pale
      "f91cf558-04a5-4fd8-8814-b1c765668b39", // HWK 21 Covert
      "f276fcc6-84a1-43c9-8d88-e7dd83a1ce58", // Assassin's HWK 21 Covert
      "73875794-5a86-410e-84a4-1b5b2f7e5a54", // ICA 19
      "35efd6dc-0387-4b56-83f0-4e6609bac93f", // Hackl 9S Covert
      "97f3ab46-e409-40dd-a0ba-8e9dd0b0345b", // Krugermeier 2-2 Silver
      "b8ec525e-8de3-4b9a-9b2a-97eb6a8dd9f6", // HWK21 Pale Homemade Silencer
      "4e66bf97-e6da-4cb6-b873-10a9af274bf4", // Concept 5
      "be4e7b4e-d895-47c1-979d-d79bfbe79a02", // ICA 19 F/A
      "092f6514-c34e-4d04-8d28-7ebbe14230d1", // "Rude Ruby"
      "15291f69-88d0-4a8f-b31b-71605ba5ff38", // Striker
      "e55c71d6-cbf6-41b8-8838-2d1be1d07e1c", // Custom 5mm
      "f755f824-bdf6-4ace-b416-abf3bae4b6d5", // Custom 5mm DTI
      "341ba426-d52d-4ae3-97a9-40b9b3633d76", // ICA 19 Chrome
      "f93b99a3-aef6-419f-b303-59470577696d", // ICA 19 Black Lilly
      "256ac829-2ec6-44de-8d5f-16801a0491df", // ICA 19 Stealth F/A "Ducky" Edition
      "214004ec-5c86-4c26-8403-9e83a9bcdd24", // ICA 19 F/A Stealth
      "482eca87-2340-43b2-bf8e-9f6dafb16b4c", // ICA 19 DTI Stealth
      "c8a09c31-a53e-436f-8421-a4dc4115f633", // Krugermeier 2-2
      "77ecaad6-652f-480d-b365-cdf90820a5ec", // "El Matador"
      "e70adb5b-0646-4f88-bd4a-85bea7a2a654", // ICA 19 Silverballer
      "ebff0c9a-e04d-4bc2-8f7a-e9c3cd6d6a93", // ICA 19 Shortballer
      "6eccc7e1-e31b-42de-8f84-b88d8e0032ea", // ICA 19 Goldballer
    ]
  },
  {
    // smgs (4th wall from right)
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "8a30c788-049a-4b83-b148-1a6db49d2ae5", // ICA SMG Raptor Covert
      "e638b949-9b96-4c41-bec4-0a8fbfb05c75", // DAK X2 Covert Special
      "a494c3c8-9a41-4398-9542-559e6a5dc1cb", // ICA SMG White Raptor Covert
      "304a4180-46ce-43ac-af61-f54bbf8a75eb", // DAK X2 Covert
      "bbabd2bd-6e21-4b9b-a361-71bc255fc9b9", // DAK DTI
      "e0de34ce-f8d1-428b-8b37-0dae7398bde3", // HX-7 Covert
      "851c8aee-3de2-48ea-ae16-667c8f180f2d", // DAK Black Covert
      "b1cb79d7-9960-4d5c-8b43-81213c8594cd", // TAC-SMG Covert
      "7bf3a6e6-b5aa-4c88-b953-c2c378d36118", // TAC-SMG S
      "e206ed81-0559-4289-9fec-e6a3e9d4ee7c", // HX-10
      "302a5fed-c166-46db-a5cb-5410eb052d29", // ICA SMG Raptor
      "ba102d90-b8c9-47b9-97eb-b462344b46c3", // TAC-SMG
      "d75bef38-8a65-45f6-9cd1-ca5e23e2f79a", // DAK X2
      "3fd9825d-8aa5-48e0-97a9-ec8f541f871a", // HX-7
    ]
  },
  {
    // shotguns (5th wall from right)
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "8598ae82-53ac-43ba-9f43-30140d6ba7ee", // Golden Sawed-Off Bartoli 12G
      "545ff36e-b43c-4a35-9ab3-680b23b9e354", // Enram HV Covert
      "f8f1acee-cb96-47a0-a969-4527251a713d", // ICA Tactical White Shotgun Covert
      "b58f4e9f-60b1-4bcb-bd87-b11dbcb8e6b2", // Sawed-Off Bartoli 12G
      "33cadd6f-3813-4be1-8e50-bd6819cb9b13", // ICA Tactical Shotgun Covert
      "f6657618-d723-419f-a71b-84d0e93402e3", // Enram HV CM
      "785c3c6b-1272-4853-94f0-a41d52f64795", // Bartoli Hunting Shotgun
      "ef4c35c7-b7d4-4886-81b5-fda089f91173", // ICA Tactical Shotgun
      "d5728a0f-fe8d-4e2d-9350-03cf4243c98e", // Enram HV
      "eca66732-a356-4c13-8e33-d0f7e87b5860", // Bartoli 12G Short H
      "7f31d897-a62f-448c-be0d-79d565e2faa7", // Bartoli 12G
      "901a3b51-51a0-4236-bdf2-23d20696b358", // Tactical Bartoli 12G
    ]
  },
  {
    // assault rifles (6th wall from right)
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "6dda9c11-d472-4ae9-aadc-b916881583a7", // TAC-4 AR Desert
      "2f6eec38-45ea-49df-83a2-0b98a858e60a", // RS-15
      "79b48d90-26aa-4b17-9332-599ed8e0bd7f", // Shashka A33 Gold
      "226c2548-53e0-4703-873c-366e2c38dc5f", // Shashka A33 Covert
      "f5ebb935-9bec-422b-b772-37adc3ba23db", // Shashka A33 H
      "7e1b2364-a190-41f7-a16d-a7d7a9a2f623", // TAC-4 S/A
      "03658b5a-b49e-4e82-82e2-f5d8c5cc602e", // TAC-4 S/A Jungle
      "7373fafa-7adb-4c14-ac02-225895f9eb7f", // TAC-4 AR Stealth
      "6e4afb04-417e-4cfc-aaa2-43f3ecca9037", // Shashka A33
      "a8309099-1b89-4492-bf37-37d4312b6615", // Sieger AR552 Tactical
      "d8aa6eba-0cb7-4ed4-ab99-975f2793d731", // Fusil G2
      "6b93848c-8f1d-42eb-816f-bab61b56d8a5", // Fusil G1-4/C
      "16edb112-58cc-4069-a7dd-ebd258b14044", // Fusil G1-4
      "a15af673-8e21-47e3-bdfa-f5dea7b5f9e9", // TAC-4 AR Auto
    ]
  },
  {
    // ancestral / ornamental (mastery unlocks)
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "cdf9db81-14a9-4047-9c95-8a3e65cd6a00", // The Ancestral Sniper Rifle
      "d3dc2ef7-da65-4cdf-bf47-771aa5797ae0", // The Ancestral Pistol
      "e82b61a6-c534-495a-bbe2-b45e9ae9a030", // The Ancestral Knife
      "935fd34c-e58c-45d3-bc66-3144752b001b", // The Ancestral Shotgun
      "dd57a213-3e76-4a38-ba47-0ac5040ce5e4", // The Ancestral Assault Rifle
      "2d0393e2-49a8-43c1-b8f3-110e4b0b0c83", // The Ornamental Sniper Rifle
      "4ad2be0d-e24f-47a2-bcc9-4c6d5f73d4ff", // The Ornamental SMG
      "23e1031b-879d-4b04-ada9-b684d9d16c22", // The Ornamental Shotgun
      "af2b1a36-a7f0-4003-aae4-a6076402542d", // The Ornamental Katana
      "f417bfec-a999-4b2f-adef-510323c75ccf", // The Ornamental Pistol
      "613b24eb-fdc1-47a3-9157-e3d0c5464baf", // The Ornamental Assault Rifle
    ]
  },
  {
    // Concrete art
    entitlements: [
      "2184790",
      "a1e9a63fa4f3425aa66b9b8fa3c9cc35",
    ],
    persistentItems: [
      "6e5e27bf-6c27-4785-8cc4-ffebd0ec3494", // The Concrete Sniper Rifle
      "0f991e64-354a-403a-afa5-b30285889377", // The Concrete Bunny Pistol
      "a5d19e9f-8ca3-4c51-9d79-15d3ea2e7771", // The Shark SMG
      "1e2bc40b-505a-4cc6-a09c-94470470985b", // The Concrete Bat
      "407df651-52d4-4871-a903-db677a7568ed", // The Concrete Shotgun
      "f2465b79-a901-42f9-93f5-22f114530849", // The Concrete Assault Rifle
    ]
  },
  {
    // Makeshift pack
    entitlements: [
      "2184791",
      "08d2bc4d20754191b6c488541d2b4fa1",
    ],
    persistentItems: [
      "fecf585b-4bdb-4a9b-9ab0-2bc44c6bd84a", // The Makeshift Katana
      "30ebff97-f1e8-4fb1-9414-3e0911c29149", // The Scrap SMG
      "05ccbb96-a1a0-4ee5-9586-cb9d9c02085e", // The Scrap Gun
      "cd7587d0-4dff-4df6-b435-6080379acb01", // The Makeshift Scrap Assault Rifle
      "9fcf5400-0784-4e71-ad57-a3e17cf88bc3", // The Makeshift Scrap Shotgun
      "3ec2d9e5-de9d-4ddc-969f-6f1565e5a291", // The Scrappy Sniper Rifle
    ]
  },
  {
    // Trinity pack
    entitlements: [
      "1829596",
      "5d06a6c6af9b4875b3530d5328f61287",
    ],
    persistentItems: [
      "fca954f6-40b1-448d-b4a8-0c543e521cc3", // ICA19 Red Trinity
      "cfa664fc-e583-4ad5-ade5-2f746d8656ca", // ICA19 White Trinity
      "563e5651-3024-4dc8-9063-93030a670ca3", // ICA19 Black Trinity
    ]
  },
  {
    // sambuca The Undying
    entitlements: [
      "2828470",
      "9220c020262f420da06eb46a4b1ce86f",
    ],
    persistentItems: [
      "00d1f430-1192-4562-be0f-5538b6d0c575", // Kronstadt Mini Flash Robo XOI-2900
      "bc1bd133-f6f6-4cee-ba73-bc1881864b22", // Kronstadt IOI-1998X Surround Earphones
      "7bfd6433-fd6e-4b82-8745-ee32c305d471", // Kronstadt Explosive Pen (Gen 2)
    ]
  },
  {
    // penicillin The Disruptor
    entitlements: [
      "2973650",
      "6cdf07da030d4f66acd50eaf3cd234c7",
      "4542910", // sports pack
      "16bcef4f91674b00ba3d7f2d4f629cec" // sports pack
    ],
    persistentItems: [
      "bb507816-3007-4ac0-ab37-714472ddb7fc", // The Disruptor Cane
      "70e6a06f-c6e0-4ce4-a0f9-6c61ec0d8fb5", // The Disruptor Kettlebell
      "718f4e10-0dd2-4468-b58c-414ea711a954", // The Disruptor Resistance Band
    ]
  },
  {
    // tomorrowland The Drop
    entitlements: [
      "3110360",
      "f04198e0ffcf49079b5ec77bb6b66891",
    ],
    persistentItems: [
      "490493af-64db-4692-b32e-d691d86bc82a", // The Club Boom 12" Vinyl Sampler
      "bc9bf630-8a8b-438c-9b63-3dd5e9245595", // The Red Light Flash Grenade
    ]
  },
  {
    // lambic The Splitter
    entitlements: [
      "3254350",
      "70a9afcc8de84b6ab0f2b45b2018559b",
    ],
    persistentItems: [
      "53a4f9bd-5aa8-4b0e-9200-4593c6966f24", // The Splitter SMG
      "ccc6b901-6f13-43be-88a1-6750cdb4a6ff", // The Splitter Kukri Knife
      "ac83255f-4419-4bca-a016-52f1326b57c5", // "Good Quark Vol. 3” VHS Tape
    ]
  },
  {
    // frenchmartini The Banker
    entitlements: [
      "3711140",
      "256eeeb3d8044aa1840e1606d268e0b2",
    ],
    persistentItems: [
      "ec9bca2c-a768-4dd0-9174-fd09067310e5", // The Banker Silenced Pistol
      "33372b70-89ab-4e1c-8b07-bbb7aa2625d2", // The Banker Rope
      "cb42999a-a4d6-456b-a457-33816dbca4fd", // The "Casino Monarchique" Chip (1.000.000)
    ]
  },
  {
    // baiju Bruce Lee
    entitlements: [
      "3957470",
      "04cb1b3e5b424308be25236f6bc1b2fb",
    ],
    persistentItems: [
      "85d6a638-677d-4e70-aeae-dd4edbad8d86", // Golden Dragon Scissors
      "06f5a374-306b-4b79-b611-50c710fdb5c1", // Kali Stick
      "fd34a776-e641-4ee7-8c46-1d6604c2545c", // Jade Dagger
    ]
  },
  {
    // bellini Eminem VS Slim Shady
    entitlements: [
      "4097630",
      "0047ddcd5e6846e881f1037c1416e3d9",
    ],
    persistentItems: [
      "93129392-9ad2-4fcf-910d-3e93eb2165a5", // The Prank Pistol
      "b124af9c-2cb7-487b-a90f-0a06b9472219", // Mr. Chainsaw Jr.
      "7b25ebd9-3993-4be5-88d4-e9b308498be7", // Jar of Mom's Spaghetti Sauce
    ]
  },
  {
    // Filur Patient Zero Requiem
    entitlements: [
      "4328240",
      "b135c766d25948c39d7dd316dbc4db53"
    ],
    persistentItems: [
      "79e6fbe5-1c1a-4620-ad3f-30533c07ad5f", // Bartoli 75S "Lucky Knight"
      "13fbc185-feed-4d02-b700-913abff0b379", // Sickle Sacrificus
      "3804e585-8523-4f29-8404-b3a9a2f2e301", // Manypass
    ]
  },
  {
    // SportsPack World Champions Pack
    entitlements: [
      "4542910",
      "16bcef4f91674b00ba3d7f2d4f629cec"
    ],
    persistentItems: [
      "1b73794b-ff9c-4d04-9454-4b32c9a9d2d3", // UL-LR Sport Rifle
      "5a4b067f-f229-4838-aabd-c61dcd82a7ad", // Aircrush 73
      "717b7a4d-8b02-4d7a-b065-434a413035db", // Consolation Prize
      "c0a4129a-216d-4137-a1c3-60e110428fdb", // Gold Medal
      "4e6da33e-acc0-4f76-8158-c7b2cb7bb9b4", // The Trickshot Duck
    ]
  },
  {
    // Pomada The Wizard
    entitlements: [
      "4621250",
      "d51a3a65928841d5b4cabad20a865006"
    ],
    persistentItems: [
      "2c2a654e-9faa-42ee-a1aa-2d84b1df06de", // TAC 'N' Yellow
      "c98ff317-52f3-46f3-a6fd-31965651f267", // Blunt Knife
      "bdc60c80-6c65-4cae-8ac0-24374a8512b7", // Beatdown Boombox
    ]
  },
  {
    // Greentini The Herbalist
    entitlements: [
      "4911210",
      "d396d245e23a401b8422116db9026a27"
    ],
    persistentItems: [
      "2e5f1dfd-332f-48b4-aa3b-0b4aad53f9f9", // "The Smoke"
      "b876fbb6-3bb5-4f10-9740-cab0d5fc156f", // Ryte LX2 Custom Mic
      "adcfb5c8-8bac-487e-baf8-f82f9fb9d32a", // Morsizzles Cookie
    ]
  },
  {
    // EG04 Getaway Pack
    entitlements: [
      "4944070",
      "7b3bf47c436644ea8fea4f95317d431c"
    ],
    persistentItems: [
      "fdd80c99-d7e5-4641-99bb-1809dd084741", // Sunsieger 300
      "af703f3f-9d67-496e-bf0a-e1e3b37093dd", // The Sweetpea Baller
      "362f3bb1-a51e-446b-9bff-3c1831f27687", // SPF 47
      "fb750df8-cf61-41fc-bba5-2791723c94ce", // Red Water Balloon
      "d9f68662-1a34-4e1e-9a04-d5fc94a072eb", // Croquet Mallet
    ]
  },
  {
    // melee 1
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "d439fb64-8713-4c54-a3f3-90730dbdf370", // Masamune
      "5c211971-235a-4856-9eea-fe890940f63a", // Antique Carved Knife
      "3c52b8c3-f4a5-4fcd-ae16-ff45b56d4351", // Collector's Lockpick
      "0363daab-49c7-4a64-9b00-c871e550f61f", // Collector's Coin
      "4404fc8d-ffc0-472d-a63a-6480be973e74", // Collector's Crowbar
      "f124aaf2-3eb2-473f-9277-e68f09869974", // Collector's Sieker Emetic Edition
      "948811dd-5cf7-4f4b-9491-f1f94a000529", // Collector's Kalmer Sedative Edition
      "8e445d94-9294-4087-af0d-178ef1f8c8f7", // Spooky Bat
      "5631dace-7f4a-4df8-8e97-b47373b815ff", // Katana
      "3dbd9ee9-f887-41bb-83bf-386324d11485", // Janbiya
      "f2a74ebc-8f07-4845-b421-2339988e1994", // Eiffel Tower Knife
      "6d4c88f3-9a09-453c-9a6e-a081f1136bf3", // Burial Dagger
      "d70c739a-6956-4771-ba9c-7f3c9206f762", // Ice Axe
      "92330cd4-1bb1-419e-98d3-ef26631504bf", // Bat Shuriken
      "1a11a060-358c-4054-98ec-d3491af1d7c6", // Fiber Wire
    ]
  },
  {
    // melee 2
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    persistentItems: [
      "c7296c5f-6c0e-4d52-98cd-e70a0d329e73", // HF Championship Bat
      "94f52181-b9ec-4363-baef-d53b4e424b74", // Saber
      "d2a7fa04-2cac-45d8-b696-47c566bb95ff", // Sapper's Axe
      "c61fea13-aaf0-4173-8fd0-9c34b43638ae", // Kukri Knife
      "e312a416-5b56-4cb5-8994-1d4bc82fbb84", // Circumcision Knife
      "9488fa1e-10e1-49c9-bb24-6635d2e5bd49", // Tanto
      "1033c25d-3d57-4c15-b7d0-acf3b45665ef", // Okinawan Tonfa
      "4dee7cd6-f447-45af-a90e-c2e234386dc3", // Concealable Baton
      "23b8ad17-1913-40ce-b3bc-2c92317801dd", // Mace
      "76d1f44c-8a78-462a-a39c-23d4101f4d6f", // Ice Pick
      "e55eb9a4-e79c-43c7-970b-79e94e7683b7", // Shuriken
      "e30a5b15-ce4d-41d5-a2a5-08dec9c4fe79", // Concealable Knife
      "75a0d0de-fe3c-47d3-b64f-7fc446ee59c4", // Quickdraw
      "c21f558b-2935-41e5-88ff-642eb1761ccc", // Baseball Bat
      "510c62c2-1f40-4a4d-9e42-da677bd116e7", // Police Baton
      "a2c56798-026f-4d0b-9480-de0d2525a119", // Folding Knife
      "62c2ac2e-329e-4648-822a-e45a29a93cd0", // Amputation Knife
      "21152383-6d79-436c-b359-0f8b4f5ed4a0", // Machete
      "c4747fa2-4958-4a02-926e-3b069cf218dc", // Claw Hammer
      "ed45f927-589d-4bad-ac1b-67e41c32e5ee", // ICA Combat Axe
    ]
  },
  {
    // Freelancer tools left
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    transientItems: [
      "6f935509-1e77-4991-baa4-d5515c20ab3e", // ICA Tripwire Mine
      "74a22451-8920-488f-883c-b5246ba0f9f3", // ICA Explosive Phone
      "3f9cf03f-b84f-4419-b831-4704cff9775c", // Fragmentation Grenade
      "59e407df-c49b-4abe-a1be-0806b026e47e", // Concussion Grenade
      "b988422a-02a6-499e-b796-302a782be3d1", // Emetic Grenade
      "a02af9a5-aefb-47e0-9d67-51cc9ec89774", // Flash Grenade Mk III
      "9aabe1cf-2a11-49d5-8baa-e8ed3ef22c3e", // The Pale Duck
      "7e52d861-481c-4f7c-87d2-6211d90586bf", // Remote Explosive Devil Rubber Duck
      "67b6eb96-89c6-43ce-ba7a-526b092a55f9", // Remote Concussion Collectors Duck
      "2bdf5016-e70b-4ac9-a3d5-f35b6743c09a", // Remote Concussion Rubber Duck
      "4ca96340-ae60-427b-a011-9e296cd67fd9", // Proximity Explosive Duck
      "0bc37bb7-dcd8-4348-a338-22fd8676a416", // Remote Explosive Classic Rubber Duck
      "2a493cf9-7cb1-4aad-b892-17abf8b329f4", // ICA Impact Explosive
      "04812f8d-fa7c-43f8-9021-5f3587dbb2a9", // ICA Micro Remote Explosive
      "ee4dd67d-e80c-4d97-8ca8-f0d05dc3a698", // ICA Proximity Micro Explosive
      "ba5c5c48-3d2e-4d4d-9dbe-f57b95200b1a", // Proximity Semtex Demo Block Mk III
      "7488229b-3fa8-4539-90ba-a7bf65798568", // Remote Semtex Demo Block Mk III
      "293af6cc-dd8d-4641-b650-14cdfd00f1de", // Breaching Charge Mk III
      "b26bb84e-8f15-4b4f-8554-52faa456cf2e", // ICA Remote Explosive Mk III
      "8e77e2c5-caa6-45fe-8594-6a75c21569ec", // ICA Proximity Concussion Device Mk III
      "7c691c03-7c6b-4eb4-9a68-898efe5eedaa", // Remote Explosive
      "fb1c7db4-2a41-4f3f-a17d-e93b205de481", // ICA Proximity Explosive Mk III
      "8afed6c5-a730-4f47-b02c-1e4608f2ae81", // ICA Remote Concussion Device
    ]
  },
  {
    // Freelancer tools middle
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    transientItems: [
      "736132de-78f3-4366-b927-ed9a401dbe26", // ICA Titanium Crowbar
      "494e74b2-f3c0-4c77-be15-8f22a6eed97b", // Handyman Wrench
      "d3387f28-866d-4262-88cb-6e5b1076bac0", // Lockpick Mk III
      "92d9acf6-fd79-4818-bda6-c4c28b123d8c", // Professional Screwdriver
      "b970a355-4296-4acc-9ec9-584e69a79eed", // Disposable Scrambler
      "6dadf34c-00f2-43f9-b4e8-6763502aa2c8", // Electronic Key Hacker
      "8b114fce-586b-4b06-b446-75d0bb4a4cfb", // Electronic Key Hacker Mk III
      "93f34bf9-2bd4-4aff-85c7-7e4a9921dfe7", // Remote EMP Charge
      "1d4f5a7c-c0fb-4d66-9e77-35ae526ef83a", // ICA Flash Phone
      "f16c9e93-3f04-4268-aafd-aa1fc187c181", // Water Canister
      "8431dd21-42ba-4da8-bfdb-6d870c9e1458", // Oil Canister
      "b9b0c5f2-41d1-4087-a57b-48a67731b699", // ICA Outstanding Service Coin
      "67559fbc-0877-4b82-9b05-6fe0cf6d7b1c", // ICA Proximity Micro Taser
      "765b2c7d-8554-463a-9ee4-de7b20822161", // ICA Remote Micro Taser
      "4c30021f-8ae4-4668-bf5d-1561b2e67d0b", // ICA Remote Micro Audio Distraction
      "9278382c-9c73-4d0b-8be2-9cb151d3667c", // ICA Remote Flash Device
      "021ed731-eebc-400a-9658-8f6fc5af9da6", // ICA Remote Taser
      "407bf3c3-6319-4573-b193-2611b0ee397e", // ICA Remote Audio Distraction Mk III
      "0209f0b7-f6de-45c2-a730-4802abe35a75", // ICA Proximity Taser
      "bbfeb648-7a9b-4fba-a5d4-7fdf84ad0017", // Remote Emetic Gas Device
    ]
  },
  {
    // Freelancer tools right
    entitlements: [
      "1829605",
      "06d4d61bbb774ca99c1661bee04fbde0",
    ],
    transientItems: [
      "ecf7f361-c2aa-4d96-b66d-e973c3e87154", // Sedative Pills
      "c5ec6168-2e5e-4340-b71a-c60f2ee6bd66", // Emetic Pills
      "49765e76-dea7-4ad4-b502-2bad7727a15f", // Lethal Pills
      "5fed2bb2-4fe9-4613-9f21-fedc19ba5eb7", // Sedative Poison Vial
      "999e005f-d49f-4606-a929-6387bf511c72", // Emetic Poison Vial
      "67637973-ff21-4b00-88c3-304f8405dbb7", // Lethal Poison Vial
      "c45e59f4-d8e1-4c37-b079-8b74b1fe9b24", // Modern Sedative Syringe
      "1c50d6e0-11c8-4cbc-be05-f51a8e5013be", // Modern Emetic Syringe
      "af9ad679-6a7c-4f8e-9700-ceb5e6887666", // Modern Lethal Syringe
      "b386cf6a-6a9b-4fb5-b879-4d55039d8ced", // Antique Sedative Syringe
      "261f1057-b1b2-4fe0-bd0d-b621102972c8", // Antique Emetic Syringe
      "1bfbb69d-c876-4d05-ab0b-f0be63b55b7a", // Antique Lethal Syringe
      "3cf48e44-6e0f-4e4d-9d21-6a4af476118c", // Chloroform Flask
      "351c144c-8687-426a-a6f0-c4abd7021062", // Sieker 1
      "808ebdcb-aafe-496a-9541-5903bf03c12e", // Kalmer 2 - Tranquilizer
    ]
  },
]
const persistentItemsToAdd = [];
const transientItemsToAdd = [];

const evergreenId = "f8ec92c2-4fa2-471e-ae08-545480c746ee";
let reset_next_load = false;

/**
 * @param {import("./controller").Controller} controller 
 */
function initPlugin(controller) {
  // Peacock version check
  if (!compare || compare(PEACOCKVERSTRING, "8.0.0") === -1) {
    log(LogLevel.ERROR, `Your version of Peacock (${PEACOCKVERSTRING}) is too old!`, "freelancer-items");
    log(LogLevel.ERROR, "Freelancer Items v2 needs at least version 8.0.0 to run.", "freelancer-items");
    return;
  }

  // set up additional /GetForPlay2 handler
  const getForPlay2 = contractRoutingRouter.stack.find(
    (e) => e.route.path === "/GetForPlay2"
  );
  const layer = getForPlay2.route.stack[getForPlay2.route.stack.length - 1];
  const originalHandle = layer.handle;

  // this function gets run on /GetForPlay2
  layer.handle = async function (req, res, next) {
    if (req.body.id === evergreenId && !only_on_button || reset_next_load) {
      const cpd = getCpd(req.jwt.unique_name, evergreenId);
      cpd["PersistentItems"] = Array.from(new Set((cpd["PersistentItems"] ?? []).concat(persistentItemsToAdd)));
      cpd["TransientItems"] = Array.from(new Set((cpd["TransientItems"] ?? []).concat(transientItemsToAdd)));
      log(LogLevel.INFO, "[Freelancer Items v2] Applied!", "freelancer-items");
      reset_next_load = false; // this is for the 'only_on_button' setting
    } else if (reset_for_merchants) {
      const contractData = controller.resolveContract(req.body.id, req.gameVersion);
      if (contractData?.Metadata?.CpdId === evergreenId) {
        const cpd = getCpd(req.jwt.unique_name, evergreenId);
        cpd["PersistentItems"] = [];
        cpd["TransientItems"] = [];
        log(LogLevel.INFO, "Items removed to make room for merchants", "freelancer-items");
      }
    }
    return await originalHandle(req, res, next);
  };

  controller.hooks.onUserLogin.tap("freelancer-items-setup", (gameVersion, userId) => {
    const ents = new Set(getUserData(userId, gameVersion).Extensions.entP);
    persistentItemsToAdd.length = 0;
    transientItemsToAdd.length = 0;

    for (const itemGroup of itemsGroups) {
      if (itemGroup.entitlements.some(ent => ents.has(ent))) {
        if (itemGroup.persistentItems && give_persistent_items)
          persistentItemsToAdd.push(...itemGroup.persistentItems);
        if (itemGroup.transientItems && give_transient_items)
          transientItemsToAdd.push(...itemGroup.transientItems);
      }
    }
  });

  if (only_on_button) {
    // add the button
    const replan_json = menuSystemDatabase.hooks.getConfig.call("/pages/pause/pausemenu/replan.json", "h3");
    replan_json.$if.$else = new_replan_json_button;

    const gnc_orig = menuSystemDatabase._getNamedConfig;
    menuSystemDatabase._getNamedConfig = function freelanceritems_getNamedConfig(configName, gameVersion, ...restargs) {
      if (gameVersion === 'h3' && configName === "/pages/pause/pausemenu/replan.json") {
        return replan_json;
      }
      return gnc_orig.call(menuSystemDatabase, configName, gameVersion, ...restargs);
    };

    // check for button press
    controller.hooks.newEvent.tap('freelancer-items', (event, { gameVersion, userId }, session) => {
      const userData = getUserData(userId, gameVersion);
      if (
        userData.Extensions?.gamepersistentdata?.menudata?.freelancer_items_plugin?.reset_on_sessionid === session.Id
        && event.Name === "ContractFailed"
      ) {
        reset_next_load = true;
      }
    });
  }

  log(LogLevel.INFO, "[Freelancer Items v2] Loaded!", "freelancer-items");
}

module.exports = initPlugin;

const new_replan_json_button = {
  "$if $eq({$currentcontractcontext}.ContractType,evergreen)": {
    "$then": {
      "view": "menu3.basic.ListElementSmall",
      "pressable": "$not $isnull {$currentcontractcontext}.Contract",
      "selectable": "$not $isnull {$currentcontractcontext}.Contract",
      "data": {
        "showningame": "$isingame",
        "title": "Reset and Exit",
        "icon": "replay"
      },
      "actions": {
        "accept": [
          {
            "busystate": {
              "blockinputs": true,
              "pausegame": false,
              "state": "eBusyState_Loading",
              "custommessage": "$loc UI_DIALOG_LOADING"
            }
          },
          {
            "set-persistent-menudata": {
              "mode": "setdata",
              "path": "freelancer_items_plugin",
              "value": {
                "reset_on_sessionid": "$currentcontractsessionid"
              }
            }
          },
          {
            "set-persistent-menudata": {
              "mode": "savependingdata"
            }
          },
          {
            "fire-page-pin": {
              "name": "ExitEvergreen"
            }
          }
        ]
      }
    }
  }
};

