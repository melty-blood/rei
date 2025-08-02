package util

import (
	"fmt"
	"math/rand"
	"strconv"
)

func GetMod(num any, divisor int, defaultNum int) int {
	var newNum int
	switch tempNum := num.(type) {
	case int:
		newNum = tempNum
	case int32:
		newNum = int(num.(int32))
	case int64:
		newNum = int(num.(int64))
	default:
		return defaultNum
	}
	return newNum % divisor
}

func GetPicNumStr(randNum int, modType int, zeroNum int) string {

	rand := rand.Intn(randNum)
	if rand == 0 {
		rand = randNum
	}
	randStr := ""
	switch modType {
	case 0:
		randStr = strconv.Itoa(rand)
	case 1:
		format := fmt.Sprintf("%%0%dd", zeroNum)
		randStr = fmt.Sprintf(format, rand)
	default:
		randStr = strconv.Itoa(rand)
	}

	return randStr
}

func PicStrJoinNum(str, numStr, ext string) string {
	return fmt.Sprintf("%s%s%s", str, numStr, ext)
}
