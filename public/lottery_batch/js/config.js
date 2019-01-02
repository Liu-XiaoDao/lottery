var levelXF = 10,	//幸福奖 300
	level3 = 5,		//三等奖 6
	level2 = 5,		//二等奖 3
	level1 = 5;		//一等奖 2

//奖项类别
window.prizeLevel = [{
		'label': 'levelXF',
		'text': '幸福奖',
		'count': 10, //总个数
		'complete': false,
		'surplus': 10,	//剩余个数
		'n': 5	//一次抽取个数
	},{
		'label': 'level3',
		'text': '三等奖',
		'count': level3,
		'complete': false,
		'surplus': level3,
		'n': 5
	},{
		'label': 'level2',
		'text': '二等奖',
		'count': level2,
		'complete': false,
		'surplus': level2,
		'n': 5
	},{
		'label': 'level1',
		'text': '一等奖',
		'count': level1,
		'complete': false,
		'surplus': level1,
		'n': 1
	}];
