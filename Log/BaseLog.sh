#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2155
# @attention 注意 1>&2 每一个日志输入都把标准输出重定向到了标准错误输出,目的是在使用log_的时候不影响函数的返回结果
#===============================================================
import=$(basename "${BASH_SOURCE[0]}" .sh)
if [[ $(eval echo '$'"${import}") == 0 ]]; then return; fi
eval "${import}=0"
#===============================================================
source ./../../BaseShell/Lang/BaseObject.sh
source ./../../BaseShell/Lang/BaseString.sh

LOG_DIR="${HOME}/.baseshell"
if [[ ! -d ${LOG_DIR} ]]; then mkdir -p "${LOG_DIR}" ;fi
LOG_TRACE_MODEL="${TRUE}"
LOG_DEBUG_MODEL="${TRUE}"

# 默认关闭,debug级别的日志会忽略
# debug级别的日志 []<-(msg:String)
function log_debug(){
  if [[ ${LOG_DEBUG_MODEL} -eq ${TRUE} ]];then
    echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID] [DEBUG]:   $*"|trim 1>&2
    echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID] [DEBUG]:   $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).debug.log" 2>&1
    echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID] [DEBUG]:   $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).log" 2>&1
  fi
}

# info级别的日志 []<-(msg:String)
function log_info(){
  echo -e "\\033[37m[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID] [INFO]:    $*\\033[0m"|trim 1>&2
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID] [INFO]:    $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).info.log"  2>&1
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID] [INFO]:    $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).log"  2>&1
}

# warn级别的日志 []<-(msg:String)
function log_warn(){
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\033[33m [WARN]\033[0m:    $*"|trim 1>&2
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\033[33m [WARN]\033[0m:    $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).info.log" 2>&1
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\033[33m [WARN]\033[0m:    $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).log" 2>&1
}

# error级别的日志 []<-(msg:String)
function log_error(){
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[31m [ERROR]\\033[0m:   $*"|trim 1>&2
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[31m [ERROR]\\033[0m:   $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).error.log" 2>&1
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[31m [ERROR]\\033[0m:   $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).log" 2>&1
}

# 用来标识成功状态的,用绿色 []<-(msg:String)
function log_success(){
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[32m [SUCCESS]\\033[0m: $*"|trim 1>&2
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[32m [SUCCESS]\\033[0m: $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).info.log" 2>&1
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[32m [SUCCESS]\\033[0m: $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).log" 2>&1
}

# @attention 当前子进程会退出
# 用来标识失败状态的,用红色, []<-(msg:String)
function log_fail(){
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[31m [FAIL]\\033[0m:    $*"|trim 1>&2
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[31m [FAIL]\\033[0m:    $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).info.log" 2>&1
  echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID]\\033[31m [FAIL]\\033[0m:    $*"|trim >> "${LOG_DIR}/$(date +%Y-%m-%d).log" 2>&1
  exit
}

# @attention 日志只会输出到日志文件中,不会输出在控制台上,默认开启
# 用来标识追踪日志 []<-(msg:String)
function log_trace(){
  if [[ ${LOG_TRACE_MODEL} -eq ${TRUE} ]];then
    echo -e "[$(date +%Y-%m-%dT%H:%M:%S)][$$ $BASHPID] [TRACE]:   $*"|trim >>"${LOG_DIR}/$(date +%Y-%m-%d)".trace.log 2>&1
  fi
}
