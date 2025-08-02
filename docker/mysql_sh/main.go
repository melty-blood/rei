package main

import (
	"fmt"
	"os"
	"os/exec"
)

func main() {
	// 建议单独拿出去打包
	if _, err := os.Stat("./sql_success"); err == nil {
		fmt.Println("sql 已经执行成功！")
		return
	}
	fmt.Println("sqlinit runing")
	data, err := os.ReadFile("./init.sql") // 读取整个文件内容
	if err != nil {
		panic(err)
	}
	fmt.Println(string(data))

	cmd := exec.Command("mysql", "-u", "root", "-e", string(data))
	output, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf("执行失败: %v\n输出: %s\n", err, string(output))
		return
	}
	fmt.Println("执行成功:\n", string(output))

	file, err := os.OpenFile("./sql_success", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0755)
	if err != nil {
		panic(err)
	}
	defer file.Close()

	_, err = file.WriteString("1\n")
	if err != nil {
		return
	}
}
