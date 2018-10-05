function $(id){
	return document.getElementById(id);
}

//包含最小值和最大值
function getRandomNumber(start,end){
	return Math.floor(Math.random()*(end-start+1)+start);
}

function parseTags(string){
	var result = string.match(/\{[^\{\}]+\}/g);
	if(result){
		for(var i=0;i<result.length;i++){
			var tag = result[i].substr(1,result[i].length-2).split(',');
			var value;
			switch(tag[0]){
				case 'direct':
					value = getRandomNumber(0,1)?'左':'右';
				break;
				
				case 'number':
					value = getRandomNumber(parseInt(tag[1]),parseInt(tag[2]));
				break;
				
				case 'img':
					value = '<img src="/draw/images/'+tag[1]+'.jpg" height="200" />';
				break;
			}
			string = string.replace(result[i],value);
		}
	}
	return string;
}

function startup(){
	if(isRunning){
		//alert('程序已经在运行中...');
		return;
	}
	isRunning = true;
	$('load').style.display = '';
	$('title').style.display = 'none';
	$('content').style.display = 'none';
	updateMeanArea();
	setTimeout(function(){
		var randomNumber = getRandomNumber(0,total-1);
		for(var i=0;i<groupItems.length;i++){
			for(var j=0;j<groupItems[i].length;j++){
			
				//抽中了
				if( randomNumber > (groupItems[i][j][0]-1) && randomNumber < (groupItems[i][j][1]+1) ){
					//显示结果
					if(typeof(groupItems[i][j][2])=='string' && groupItems[i][j][2].length>0){
						$('title').style.display = '';
						$('title').innerHTML = parseTags(groupItems[i][j][2]);
					}
					if(typeof(groupItems[i][j][3])=='string' && groupItems[i][j][3].length>0){
						$('content').style.display = '';
						$('content').innerHTML = parseTags(groupItems[i][j][3]);
					}
					
					$('load').style.display = 'none';
					isRunning = false;
					return;
				}
				
			}
		}
	},500);
}

//更新平均概率项目的范围
function updateMeanArea(){
	meanIndex = index;
	//开始计算平均概率
	//余下的概率点的数量
	var pointCount = total - meanIndex;
	
	//如果剩下的概率点大于项目的数量，小于的话，也就是每个项目合不到一个概率点，这样是不合理的，这是概率设置问题
	if(pointCount>groupItems[1].length){
	
		//如果不能整除有余数的话，就把余下的随机加到平均分配的项目中
		var itemsLength = groupItems[1].length;
		var remain = pointCount%itemsLength;
		var meanPoint =(pointCount-remain)/itemsLength;
		
		var add = [];
		
		//统计随机累加到项目上的值
		for(var i=0,r;i<remain;i++){
			r = getRandomNumber(0,itemsLength-1);
			if(!add[r])add[r] = 0;
			add[r]++;
		}
		
		//设置每个项目的范围
		for(var i=0;i<itemsLength;i++){
			groupItems[1][i][0] = meanIndex;
			meanIndex += meanPoint+(add[i]?add[i]:0);
			groupItems[1][i][1] = meanIndex-1;
		}
	}else{
		alert('定义之后剩下的概率点不足以平均分配');
		isError = true;
	}
}

//概率定义，*代表平均分配自定义概率剩下的
var items = [
	
	[	'1/100',		'转移牌'	,	'你可以把你所抽到的转移给其他人'	],
	[	'1/100',		'命运牌'	,	'你可以拒绝你所抽到的你不乐意做的事情，但必须再抽一次'	],
	[	'1/150',		'抗拒牌'	,	'你可以直接拒绝你所抽到的你不乐意做的事情'	],
	[	'1/100',		'防御牌'	,	'别人对你使用转移牌无效'	],
	[	'1/100',		'机会牌'	,	'可凭此牌获得一次抽奖的机会，可以自己抽也可以指定别人抽'	],
	[	'1/150',		'闪避牌'	,	'该你抽奖时你可以使用闪避令牌闪过'	],
	[	'1/100',		'挑战牌'	,	'你可以向指定的一人发起《石头剪刀布》的挑战，3vs2赢的一方可决定任意一方抽奖一次'	],
	[	'1/100',		'丰收牌'	,	'大家全部都再抽一轮'	],
	[	'1/100',		'捆绑牌'	,	'你可以将你抽到的和指定的一人同甘共苦'	],
	[	'1/100',		'惜玉牌'	,	'主动报名代替当前抽奖者抽奖'	],
	[	'1/100',		'平安牌'	,	'指定一人跳过此轮抽奖'	],
	[	'*',		'额头上贴纸条一张'	],
	[	'*',		'背或抱你{direct}边的第{number,1,3}位同性原地转{number,3,5}圈'	],
	[	'*',		'对你{direct}边的第{number,1,3}位异性表白'	],
	[	'*',		'和你{direct}边的第{number,1,3}位异性对视30秒'	],
	[	'*',		'对你{direct}边的人瞪着眼睛愤怒的说：你神经病啊！'	],
	[	'*',		'对你{direct}边的人说：亲爱的！难道你不爱我了吗？难道你真的不爱我了吗？噢...Shit！'	],
	[	'*',		'脑筋急转弯一个','可求助网络最多30秒时间'	],
	[	'*',		'笑话一个','可求助网络最多30秒时间'	],
	[	'*',		'学一种动物的叫声'	],
	[	'*',		'模仿一种动物的动作'	],
	[	'*',		'表演一个撒娇'	],
	[	'*',		'表演喜怒哀乐四种表情'	],
	[	'*',		'和你{direct}边的第{number,1,2}个人玩摸迷藏','你必须闭着眼睛在3分钟内找到他，游戏开始之前，他可以和他左右5人范围内的任何一人交换位置'	],
	[	'*',		'模仿一下孙悟空'	],
	[	'*',		'被你{direct}边的第{number,1,2}位同性挠肋骨10秒钟'	],
	[	'*',		'对墙壁大声说三次“我爱你”'	],
	[	'*',		'做出白痴或装纯情的表情'	],
	[	'*',		'对着窗外大喊“我好寂寞啊”'	],
	[	'*',		'用扭屁股的方式写出一个笔画不少于5的字让大家猜'	],
	[	'*',		'大笑5秒再大哭5秒，反复3次'	],
	[	'*',		'双手向后抱头，蹲下学青蛙跳{number,3,5}下，每跳一下都要发出“呱”的声音'	],
	[	'*',		'请流利的朗读文言文《季姬击鸡记》','季姬寂，集鸡，鸡即棘鸡。棘鸡饥叽，季姬及箕稷济鸡。鸡既济，跻姬笈，季姬忌，急咭鸡，鸡急，继圾几，季姬急，即籍箕击鸡，箕疾击几伎，即齑，鸡叽集几基，季姬急极屐击鸡，鸡既殛，季姬激，即记《季姬击鸡记》。'	],
	[	'*',		'请表演舔自己的鼻子'	],
	[	'*',		'闭着眼睛画一只动物，让大家猜'	],
	[	'*',		'嘴里含着水演唱《世上只有妈妈好》'	],
	[	'*',		'嘴里含着水对你{direct}边第{number,1,3}位异性讲大话西游里的经典台词'	],
	[	'*',		'请表演从小腿抚摸到臀部的动作'	],
	[	'*',		'请表演一个甩头发耍酷的造型，并说：飘柔就是这样自信'	],
	[	'1/20',		'百姓安居乐业，天下一片祥和，什么事情都没有发生'	],
	[	'*',		'唱《青藏高原》的最后一句'	],
	[	'*',		'做一个大家都满意的鬼脸'	],
	[	'*',		'模仿一下大猩猩','{img,xingxing}'	],
	[	'*',		'对窗外大喊：我是猪头'	],
	[	'*',		'走个猫步让大家看看'	],
	[	'*',		'做自己认为最性感最妩媚的表情'	],
	[	'*',		'蹲在凳子上做便秘样子10秒钟'	],
	[	'*',		'摆3个芙蓉姐姐的S型','{img,furongjiejie}'	],
	[	'*',		'邀请你{direct}边第{number,1,3}个人和自己一起一边做动作一边唱“我爱洗澡，皮肤好好，噢.噢..噢.噢”'	],
	[	'*',		'深情地吻墙{number,5,10}秒钟'	],
	[	'*',		'对你{direct}边的第{number,1,3}个人说：“我将把你紧紧地搂在怀中，吻你亿万次，像在赤道上面那样炽烈的吻。”'	],
	[	'*',		'对你{direct}边第{number,1,3}位男生一边捶他的胸一边说：你好讨厌哦'	],
	[	'*',		'和你{direct}边第{number,1,3}个人，十指相扣，深情对视，朗诵骆宾王的《鹅》。'	],
	[	'*',		'对着墙壁大声：我很傻，我非常傻，我是超级大傻瓜'	],
	[	'*',		'模仿一段印象深刻的电视广告，比如脑白金'	],
	[	'*',		'做一个很萌的动作'	],
	[	'*',		'说说自己做过的一件最糗事'	],
	[	'*',		'向前一步然后闭着眼睛，左转5圈，右转5圈，走回到自己的位置'	],
	[	'*',		'用肢体语言把{direct}边第{number,1,3}个人逗笑'	],
	//[	'*',		'恭喜你下一次的晨会有你主持啦'	,	'仅第一个抽到的有效'	]	
];

//数字越大，几率精确度越高
var total = 5000;

//正在运行
var isRunning = false;

//错误
var isError = false;

//下个区间的开始
var index = 0;
var meanIndex=0;

//将定义概率的和平均分配的分离开,并将已定义概率的转换为范围
var groupItems = [[],[]];
for(var i=0,l=items.length;i<l;i++){
	//是平均分配的			
	if(items[i][0]=='*'){
		//直接加入到分组数组中
		groupItems[1].push([0,0,items[i][1],items[i][2]]);
	//是指定概率的
	}else{
		var chance = items[i][0].split('/');
		var nextStartPoint = index+Math.floor(parseInt(chance[0])/parseInt(chance[1])*total);
		if(nextStartPoint<total){
			//数字等于开始或结束数字，或者在两者中间，都是属于该范围，例如：(0-11,12-25)两个范围，分别有12，24个取值，12是属于(12-25)的范围内的
			groupItems[0].push([index,nextStartPoint-1,items[i][1],items[i][2]]);
			//下一个范围的开始，一直循环持续下去
			index = nextStartPoint;
		}else{
			alert('定义的概率超出范围');
			isError = true;
		}
		console.log(groupItems);
	}
}

if(!isError)
document.onkeyup = function(e){
	e = e || event;
	var key = e.which || e.keyCode;
	if(key!==116)startup()
};
		
