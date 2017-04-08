window.onload = function(){
    // 拿到所有的图片
    var allImg = document.getElementsByTagName("img");
//    alert(allImg.length);
    // 遍历
    for(var i=0; i<allImg.length; i++){
       // 取出单个图片对象
        var img = allImg[i];
        img.id = i;
       // 监听点击
        img.onclick = function(){
            window.location.href = 'silence:///testFunc'
        }
    }
    
    // 往网页尾部加入一张图片
    var img = document.createElement('img');
    img.src = 'http://www.playcode.cc/wp-content/uploads/2017/04/pp150.jpeg';
    document.body.appendChild(img);
}
