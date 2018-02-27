---
title: phpexcel内存泄漏问题
tags:
  - PHP
  - PHPExcel
id: 313673
categories:
  - 转载
date: 2013-11-27 09:01:15
---

使用 PHPExcel 来生成 excel 文档是比较消耗内存的，有时候可能会需要通过一个循环来把大数据切分成若干个小的 excel 文档保存来避免内存耗尽。

然而 PHPExcel 存在 circular references 的情况（貌似在最新的 1.6.5 版本中仍然没有去解决这个问题），如果在一次 http 请求过程中反复多次构建 PHPExcel 及 PHPExcel_Writer_Excel5 对象实例来完成多个 excel 文档生成操作的话，所有被构建的对象实例都无法在 http 请求结束之前及时释放，从而造成内存泄漏。

解决办法是在 PHPExcel_Worksheet 类中增加方法：

<span style="font-family: 'courier new', courier, monospace;"> public function Destroy() {
foreach($this-&gt;_cellCollection as $index =&gt; $dummy) {
$this-&gt;_cellCollection[$index] = null;
}
}</span>

并在 PHPExcel 类中增加方法：

<span style="font-family: 'courier new', courier, monospace;"> public function Destroy() {
foreach($this-&gt;_workSheetCollection as $index =&gt; $dummy) {
$this-&gt;_workSheetCollection[$index]-&gt;Destroy();
$this-&gt;_workSheetCollection[$index] = null;
}
}</span>

然后在需要资源回收的地方显式的调用 PHPExcel::Destroy() 来处理循环引用的问题。注意 __destruct() 方法是在对象被认为可以被释放的时候才会被调用，所以循环引用的处理不能放到 __destruct() 来进行。