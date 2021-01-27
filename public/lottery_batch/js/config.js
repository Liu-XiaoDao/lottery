var levelXF = 45,	//幸福奖 300
	level3 = 16,		//三等奖 6
	level2 = 7,		//二等奖 3
	level1 = 1;		//一等奖 2

//奖项类别
window.prizeLevel = [{
		'label': 'levelXF',
		'text': '四等奖',
		'count': 45, //总个数
		'complete': false,
		'surplus': 45,	//剩余个数
		'n': 3	//一次抽取个数
	},{
		'label': 'level3',
		'text': '三等奖',
		'count': level3,
		'complete': false,
		'surplus': level3,
		'n': 4
	},{
		'label': 'level2',
		'text': '二等奖',
		'count': level2,
		'complete': false,
		'surplus': level2,
		'n': 4
	},{
		'label': 'level1',
		'text': '一等奖',
		'count': level1,
		'complete': false,
		'surplus': level1,
		'n': 1
	}];
