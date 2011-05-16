# -*- encoding : utf-8 -*-
require File.expand_path("../environment",__FILE__)

job "update_credit" do |args|
  WarningXuefenStudent.delete_all
  Student.all.each do |s|
    val = s.yixiu*1.0/s.has_xueqi
    next if val==0
    p "#{s.name}:#{val}"
    WarningXuefenStudent.create!(student_id:s.id,val:val) if val < args["threshold"]
  end
end

job "update_klass2s" do |args|
  Klass2.delete_all
  Student.all.each do |student|
    next unless student.klass
    k = Klass2.where(name:student.zym,grade_id:student.klass.grade_id).first
    k ||= Klass2.create!(name:student.zym,grade_id:student.klass.grade_id)
    student.klass2_id = k.id
    student.save
  end
end