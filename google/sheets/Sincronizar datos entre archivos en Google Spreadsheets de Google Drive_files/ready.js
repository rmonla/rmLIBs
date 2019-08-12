/*! http://tinynav.viljamis.com v1.1 by @viljamis */
(function(a,i,g){a.fn.tinyNav=function(j){var b=a.extend({active:"selected",header:"",label:""},j);return this.each(function(){g++;var h=a(this),d="tinynav"+g,f=".l_"+d,e=a("<select/>").attr("id",d).addClass("tinynav "+d);if(h.is("ul,ol")){""!==b.header&&e.append(a("<option/>").text(b.header));var c="";h.addClass("l_"+d).find("a").each(function(){c+='<option value="'+a(this).attr("href")+'">';var b;for(b=0;b<a(this).parents("ul, ol").length-1;b++)c+="- ";c+=a(this).text()+"</option>"});e.append(c);
b.header||e.find(":eq("+a(f+" li").index(a(f+" li."+b.active))+")").attr("selected",!0);e.change(function(){i.location.href=a(this).val()});a(f).after(e);b.label&&e.before(a("<label/>").attr("for",d).addClass("tinynav_label "+d+"_label").append(b.label))}})}})(jQuery,this,0);

$(function () {
	
	
	$('.oo').click(function(){
		location.href = $(this).data('l');
		return false;
	});

	
});

$(document).ready(function(){


	$(".menu ul").tinyNav();

	// Twitter Rulez!!!
	var twitterUser = "ikhuerta";
	var tweets = 5;
	$.getJSON("http://api.twitter.com/1/statuses/user_timeline.json?screen_name="+twitterUser+"&count=" + (tweets*2) +"&callback=?",function(json){
		html = "<ul class='myTweets'>";
		var urlregex = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gi;
		var userregex = /(\@([-A-Z0-9+&\/%?=~_|!:,.;]*))/gi;
		var hashtagregex = /(\#([-A-Z0-9+&\/%?=~_|!:,.;]*))/gi;
		var count = 0;
		for (i=0;i<json.length;i++)
		{
			if (json[i].in_reply_to_screen_name==null)
			{
				html += "<li><p class='text'>" + json[i].text.replace(urlregex,"<a class='url' href='$1' rel='nofollow'>$1</a>").replace(userregex,"<a class='user' href='http://twitter.com/$2' rel='nofollow'>$1</a>").replace(hashtagregex,"<a class='hashtag' href='http://twitter.com/#search?q=$1' rel='nofollow'>$1</a>") + "</p>";
				html += "<p><a href='http://twitter.com/home?status=RT @"+twitterUser+" "+json[i].text+"' rel='nofollow'>[ReTweet]</a> ";
				html += "<a href='http://twitter.com/home?status=@"+twitterUser+" &amp;in_reply_to_status_id=" + json[i].id + "&amp;in_reply_to="+twitterUser+"' rel='nofollow'>[Responder]</a></p></li>";
				count++;
			}
			if (count >= tweets) break;
		}
		html += "</ul>";
		$("#sidebar .twitter").append(html);
	})

	

	 
	

});// End OnReady

