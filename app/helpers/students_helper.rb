# -*- encoding : utf-8 -*-
module StudentsHelper
  def table_edit_tag(x,color='white')
    if params[:edit] == x
      '[<a href="/students/'+@student.id.to_s+'" style="color:'+color+'">取消编辑</a>]'
    else
      '[<a href="/students/'+@student.id.to_s+'?edit='+x+'" style="color:'+color+'">编辑</a>]'
    end
  end
  def score_to_color(x)
    if x>=95
      "#FF0F00"
    elsif x>=90
      "#FF6600"
    elsif x>=85
      "#FF9E01"
    elsif x>=80
      "#FCD202"
    elsif x>=75
      "#F8FF01"
    elsif x>=70
      "#B0DE09"
    elsif x>=65
      "#04D215"
    elsif x>=60
      "#0D8ECF"
    elsif x>=55
      "#0D52D1"
    elsif x>=50
      "#2A0CD0"
    elsif x>=45
      "#8A0CCF"
    elsif x>=40
      "#CD0D74"
    elsif x>=35
      "#754DEB"
    elsif x>=30
      "#DDDDDD"
    elsif x>=25
      "#999999"
    elsif x>=20
      "#333333"
    else
      "#000000"
    end
  end
end
