SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for endpoints
-- ----------------------------
DROP TABLE IF EXISTS `endpoints`;
CREATE TABLE `endpoints` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type_schema` varchar(10240) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prompt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `ctime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_tid` (`type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of endpoints
-- ----------------------------
BEGIN;
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (1, '132e14f5b3bdff04165449b37cad39ac', 'ShareOrNot', '// The following is a schema definition for determining whether a user wants to share a post or not:\n\nexport interface ShareOrNot {\n  isShare: boolean;\n  url: string;\n  comment: string;\n}', 'https://github.com/shengxia/RWKV_Role_Playing_API 一个基于Flask实现的RWKV角色扮演API', NULL);
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (2, 'dbd3c5e8b0d679fc81d33ff1f42a67e7', 'CustomerHouseRequest', '// 以下是客户的房屋需求数据结构定义:\nexport interface CustomerHouseRequest {\n  area: string;\n  roomCount: number;\n  budget: string;\n  floor: string;\n  isContinueGuiding: boolean;  // 是否需要继续引导,如果提取出的信息过少，需要继续引导\n  nextQuestion: string; // 引导话术，如果isContinueGuiding为true，请生成引导话术\n}', '用户：找一个福道大厦附近的3居室\n经纪人：大概多少预算呀？\n用户：500万以内\n经纪人：对楼层有要求吗？\n用户：不要一层', NULL);
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (3, 'b72eabec250a9707761516c12ef318b1', 'QuestionAnwserOrNot', '// 以下是判断输入内容是否是QA对的数据结构定义:\nexport interface QuestionAnwserOrNot {\n  isQuestionAndAnwserContent: boolean;\n}', 'Q1: 出差乘坐火车票、飞机票的报销标准是什么？\nA: （1）火车硬卧及动车二等座可报销，包括因工作原因或不可抗力因素产生的退票及改签费用。火车商务座、一等座自费升级，公司不予报销升级费用。若火车二等座售罄且一等座不超过飞机票经济舱全价费用，留取相应证明资料后可选择火车一等座； ', NULL);
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (4, '9f992b65d3899dbb54a19823db7dd25c', 'IntentRecognition', '// The following is the structural definition of intention recognition results.\n//\n// The intention value range descibed as bellow:\n//   `share`: user want to share a link\n//   `download`: user want to download something\n//   `question`: user ask a question\n//   `summarize`: user want to summarize something\n//   `other`: user\'s intention is not clear\n//\n// If the intention is `other` or `question`, anwser for `user request` as an helpful assistant, and fill the `reply` field \nexport interface IntentRecognition {\n  intention: string;\n  reply: string;\n}', 'what\'s 1 plus 1', NULL);
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (5, '67178ce98d7cb7e6314577b013e11f81', 'Person', '// The following is a schema definition for determining whether a user wants to share a post or not:\n\nexport interface Person {\n  name: string;\n  age: number;\n  gender: string;\n  hobby: string;\n  job: string;\n}', '我叫田瑗，性别女，1990年出生，喜欢户外运动，职业与旅游相关', NULL);
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (6, '334d7b8d15f795abac20fef697ae96b6', 'CalendarActions', '// The following types define the structure of an object of type CalendarActions that represents a list of requested calendar actions\n\nexport type CalendarActions = {\n    actions: Action[];\n};\n\nexport type Action =\n    | AddEventAction\n    | RemoveEventAction\n    | AddParticipantsAction\n    | ChangeTimeRangeAction\n    | ChangeDescriptionAction\n    | FindEventsAction\n    | UnknownAction;\n\nexport type AddEventAction = {\n    actionType: \'add event\';\n    event: Event;\n};\n\nexport type RemoveEventAction = {\n    actionType: \'removeEvent\';\n    eventReference: EventReference;\n};\n\nexport type AddParticipantsAction = {\n    actionType: \'add participants\';\n    // event to be augmented; if not specified assume last event discussed\n    eventReference?: EventReference;\n    // new participants (one or more)\n    participants: string[];\n};\n\nexport type ChangeTimeRangeAction = {\n    actionType: \'change time range\';\n    // event to be changed\n    eventReference?: EventReference;\n    // new time range for the event\n    timeRange: EventTimeRange;\n};\n\nexport type ChangeDescriptionAction = {\n    actionType: \'change description\';\n    // event to be changed\n    eventReference?: EventReference;\n    // new description for the event\n    description: string;\n};\n\nexport type FindEventsAction = {\n    actionType: \'find events\';\n    // one or more event properties to use to search for matching events\n    eventReference: EventReference;\n};\n\n// if the user types text that can not easily be understood as a calendar action, this action is used\nexport interface UnknownAction {\n    actionType: \'unknown\';\n    // text typed by the user that the system did not understand\n    text: string;\n}\n\nexport type EventTimeRange = {\n    startTime?: string;\n    endTime?: string;\n    duration?: string;\n};\n\nexport type Event = {\n    // date (example: March 22, 2024) or relative date (example: after EventReference)\n    day: string;\n    timeRange: EventTimeRange;\n    description: string;\n    location?: string;\n    // a list of people or named groups like \'team\'\n    participants?: string[];\n};\n\n// properties used by the requester in referring to an event\n// these properties are only specified if given directly by the requester\nexport type EventReference = {\n    // date (example: March 22, 2024) or relative date (example: after EventReference)\n    day?: string;\n    // (examples: this month, this week, in the next two days)\n    dayRange?: string;\n    timeRange?: EventTimeRange;\n    description?: string;\n    location?: string;\n    participants?: string[];\n};\n', 'I need to get my tires changed from 12:00 to 2:00 pm on Friday March 15, 2024', NULL);
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (7, '2dafcb4800ec144356799d5f4da07f32', 'SentimentResponse', 'export interface SentimentResponse {\n    sentiment: \"negative\" | \"neutral\" | \"positive\";  // The sentiment of the text\n}\n', 'it\'s very rainy outside', NULL);
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (8, '6a5269dc1455d181cedba3e806807431', 'Cart', '// The following is a schema definition for ordering lattes.\n\nexport interface Cart {\n    items: (LineItem | UnknownText)[];\n}\n\n// Use this type for order items that match nothing else\nexport interface UnknownText {\n    type: \'unknown\',\n    text: string; // The text that wasn\'t understood\n}\n\nexport interface LineItem {\n    type: \'lineitem\',\n    product: Product;\n    quantity: number;\n}\n\nexport type Product = BakeryProducts | LatteDrinks | EspressoDrinks | CoffeeDrinks;\n\nexport interface BakeryProducts {\n    type: \'BakeryProducts\';\n    name: \'apple bran muffin\' | \'blueberry muffin\' | \'lemon poppyseed muffin\' | \'bagel\';\n    options: (BakeryOptions | BakeryPreparations)[];\n}\n\nexport interface BakeryOptions {\n    type: \'BakeryOptions\';\n    name: \'butter\' | \'strawberry jam\' | \'cream cheese\';\n    optionQuantity?: OptionQuantity;\n}\n\nexport interface BakeryPreparations {\n    type: \'BakeryPreparations\';\n    name: \'warmed\' | \'cut in half\';\n}\n\nexport interface LatteDrinks {\n    type: \'LatteDrinks\';\n    name: \'cappuccino\' | \'flat white\' | \'latte\' | \'latte macchiato\' | \'mocha\' | \'chai latte\';\n    temperature?: CoffeeTemperature;\n    size?: CoffeeSize;  // The default is \'grande\'\n    options?: (Milks | Sweeteners | Syrups | Toppings | Caffeines | LattePreparations)[];\n}\n\nexport interface EspressoDrinks {\n    type: \'EspressoDrinks\';\n    name: \'espresso\' | \'lungo\' | \'ristretto\' | \'macchiato\';\n    temperature?: CoffeeTemperature;\n    size?: EspressoSize;  // The default is \'doppio\'\n    options?: (Creamers | Sweeteners | Syrups | Toppings | Caffeines | LattePreparations)[];\n}\n\nexport interface CoffeeDrinks {\n    type: \'CoffeeDrinks\';\n    name: \'americano\' | \'coffee\';\n    temperature?: CoffeeTemperature;\n    size?: CoffeeSize;  // The default is \'grande\'\n    options?: (Creamers | Sweeteners | Syrups | Toppings | Caffeines | LattePreparations)[];\n}\n\nexport interface Syrups {\n    type: \'Syrups\';\n    name: \'almond syrup\' | \'buttered rum syrup\' | \'caramel syrup\' | \'cinnamon syrup\' | \'hazelnut syrup\' |\n        \'orange syrup\' | \'peppermint syrup\' | \'raspberry syrup\' | \'toffee syrup\' | \'vanilla syrup\';\n    optionQuantity?: OptionQuantity;\n}\n\nexport interface Caffeines {\n    type: \'Caffeines\';\n    name: \'regular\' | \'two thirds caf\' | \'half caf\' | \'one third caf\' | \'decaf\';\n}\n\nexport interface Milks {\n    type: \'Milks\';\n    name: \'whole milk\' | \'two percent milk\' | \'nonfat milk\' | \'coconut milk\' | \'soy milk\' | \'almond milk\' | \'oat milk\';\n}\n\nexport interface Creamers {\n    type: \'Creamers\';\n    name: \'whole milk creamer\' | \'two percent milk creamer\' | \'one percent milk creamer\' | \'nonfat milk creamer\' |\n        \'coconut milk creamer\' | \'soy milk creamer\' | \'almond milk creamer\' | \'oat milk creamer\' | \'half and half\' |\n        \'heavy cream\';\n}\n\nexport interface Toppings {\n    type: \'Toppings\';\n    name: \'cinnamon\' | \'foam\' | \'ice\' | \'nutmeg\' | \'whipped cream\' | \'water\';\n    optionQuantity?: OptionQuantity;\n}\n\nexport interface LattePreparations {\n    type: \'LattePreparations\';\n    name: \'for here cup\' | \'lid\' | \'with room\' | \'to go\' | \'dry\' | \'wet\';\n}\n\nexport interface Sweeteners {\n    type: \'Sweeteners\';\n    name: \'equal\' | \'honey\' | \'splenda\' | \'sugar\' | \'sugar in the raw\' | \'sweet n low\' | \'espresso shot\';\n    optionQuantity?: OptionQuantity;\n}\n\nexport type CoffeeTemperature = \'hot\' | \'extra hot\' | \'warm\' | \'iced\';\n\nexport type CoffeeSize = \'short\' | \'tall\' | \'grande\' | \'venti\';\n\nexport type EspressoSize = \'solo\' | \'doppio\' | \'triple\' | \'quad\';\n\nexport type OptionQuantity = \'no\' | \'light\' | \'regular\' | \'extra\' | number;\n', 'two tall lattes. the first one with no foam. the second one with whole milk.', NULL);
INSERT INTO `endpoints` (`id`, `type_id`, `type_name`, `type_schema`, `prompt`, `ctime`) VALUES (9, '3d4e92513d75c28f02637be1450fc3dc', 'Order', '// an order from a restaurant that serves pizza, beer, and salad\nexport type Order = {\n    items: (OrderItem | UnknownText)[];\n};\n\nexport type OrderItem = Pizza | Beer | Salad | NamedPizza;\n\n// Use this type for order items that match nothing else\nexport interface UnknownText {\n    itemType: \'unknown\',\n    text: string; // The text that wasn\'t understood\n}\n\n\nexport type Pizza = {\n    itemType: \'pizza\';\n    // default: large\n    size?: \'small\' | \'medium\' | \'large\' | \'extra large\';\n    // toppings requested (examples: pepperoni, arugula)\n    addedToppings?: string[];\n    // toppings requested to be removed (examples: fresh garlic, anchovies)\n    removedToppings?: string[];\n    // default: 1\n    quantity?: number;\n    // used if the requester references a pizza by name\n    name?: \"Hawaiian\" | \"Yeti\" | \"Pig In a Forest\" | \"Cherry Bomb\";\n};\n\nexport interface NamedPizza extends Pizza {\n}\n\nexport type Beer = {\n    itemType: \'beer\';\n    // examples: Mack and Jacks, Sierra Nevada Pale Ale, Miller Lite\n    kind: string;\n    // default: 1\n    quantity?: number;\n};\n\nexport const saladSize = [\'half\', \'whole\'];\n\nexport const saladStyle = [\'Garden\', \'Greek\'];\n\nexport type Salad = {\n    itemType: \'salad\';\n    // default: half\n    portion?: string;\n    // default: Garden\n    style?: string;\n    // ingredients requested (examples: parmesan, croutons)\n    addedIngredients?: string[];\n    // ingredients requested to be removed (example: red onions)\n    removedIngredients?: string[];\n    // default: 1\n    quantity?: number;\n};\n\n', 'I\'d like two large, one with pepperoni and the other with extra sauce.  The pepperoni gets basil and the extra sauce gets Canadian bacon.  And add a whole salad. Make the Canadian bacon a medium. Make the salad a Greek with no red onions.  And give me two Mack and Jacks and a Sierra Nevada.  Oh, and add another salad with no red onions.', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
