from glob import glob
import subprocess
from os import path
import re
import os
import time
import argparse

if __name__ == '__main__':
  report_fileName = "function " + time.strftime("%m%d_%H:%M", time.localtime()) + ".txt"
  if(path.exists(report_fileName)):
    os.system(f"rm {report_fileName}")
  report_f = open(report_fileName, "w+")

  parser = argparse.ArgumentParser(description='Automaticly test. Output in ./build.', formatter_class=argparse.RawDescriptionHelpFormatter)
  parser.add_argument("-test_path", type=str, help="the path of the test cases with glob style.", default="./_sysyruntime2021/*/*")
  parser.add_argument("-a", "--all", help="output the results for all test cases.", action="store_false")
  parser.add_argument("-r", "--run", help="link the asm files and run the executable files.", action="store_false")
  parser.add_argument("-v", "--verbose", help="print compile time (and exec time when the option [-r] is specified) for only incorrect test cases (or every test case when the option [-a] is specified).", action="store_false")
  parser.add_argument("-L", "--linked_library_path", type=str, help="the path of the linked library.", default="./_sysyruntime2021")
  args = parser.parse_args()

  CompilerPath = './calcifercompiler/build/calcifer'
  GccArgs = f'-march=armv7-a -L {args.linked_library_path} -lsysy -static'
  asmFolder = './asm_output_func'
  exeFolder = './aexe_output_func'

  if not path.exists(asmFolder):
    os.system(f"mkdir {asmFolder}")
  else:
    os.system(f"rm -rf {asmFolder}/*")

  if not path.exists(exeFolder):
    os.system(f"mkdir {exeFolder}")
  else:
    os.system(f"rm -rf {exeFolder}/*")

  # make_res = subprocess.call("cd ./calcifercompiler/build && cmake .. && make -j8", shell=True)
  make_res = subprocess.call("cd ./calcifercompiler/build && make -j8", shell=True)
  if make_res != 0:
    report_f.write("build compiler failed.\n")
    exit()
  report_f.write('\n')

  files = glob(args.test_path, recursive=True)
  files.sort()
  bug_num = len(files)

  all_time_seconds=0
  all_time_useconds=0

  for file in files:
    filepath_noext, _ = path.splitext(file)
    path2this, filename = path.split(file) # print("path2this: "+path2this)
    filename_noext, suffix =path.splitext(filename)
    # 跳过非.sy的
    if suffix != ".sy":
      continue
    asm_file = asmFolder+"/"+filename_noext+".s"
    exec_file = exeFolder+"/"+filename_noext
    stdin_file = filepath_noext+".in"
    stdout_file = filepath_noext+".out"

    report_f.write("{:10s}:{:35s}{:10s}:{}\n".format("Processing",filename,"full path",file))
    # print("{:10s}:{:35s}{:10s}:{}".format("Processing",filename,"full path",file))
    print("{:10s}:{:35s}{:10s}:{}".format("\033[34mProcessing\033[0m", filename,"full path",file))

    # Compile
    time_start = time.time()
    if subprocess.call(f"{CompilerPath} -S -o {asm_file} {file}".split()) != 0:
      report_f.write("compile failed.\n")
      continue

    time_end = time.time()
    compile_time = (time_end - time_start) # s
    if args.all and args.verbose:
      print("{:10s}:{:.6f}s".format("compile tm",compile_time))
      report_f.write("{:10s}:{:.6f}s\n".format("compile tm",compile_time))

    if not args.run:
      bug_num-=1
      report_f.write("{:10s}:{}\n".format("status","OK!"))
      print("{:10s}:{}".format("status","OK!"))
    else:
      # GCC Link
      link_cmd = f"gcc -o {exec_file} {asm_file} {GccArgs}"
      # time_start = time.time()
      if subprocess.call(link_cmd.split()) != 0:
        report_f.write("link failed.\n\n")
        continue
      time_end = time.time()
      # link_time = (time_end - time_start) # s
      # print("{:10s}:{:.6f}s".format("link time",link_time))

      # Exec
      exec_cmd = f"{exec_file}"
      if path.exists(stdin_file):
        stdin = open(stdin_file, 'r')
      else:
        stdin = None
      time_start = time.time()
      subp = subprocess.Popen(exec_cmd.split(), bufsize=0, stdin=stdin, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='unicode_escape')
      exec_out, exec_err = subp.communicate()
      ret_code = subp.returncode
      time_end = time.time()
      run_time = (time_end - time_start) # s
      exec_time = (re.search("[0-9]+H.*us",exec_err))
      
      if args.all and args.verbose:
        print("{:10s}:{:.6f}s".format("run time",run_time))
        report_f.write("{:10s}:{:.6f}s\n".format("run time",run_time))
        if exec_time != None:
          exec_time=exec_time.group()
          detail_time =re.search(("-([0-9]+)S-([0-9]+)us"), exec_time)
          if detail_time != None:
            all_time_seconds+=int(detail_time.group(1))
            all_time_useconds+=int(detail_time.group(2))
          report_f.write("{:10s}:{}\n".format("exec time",exec_time))

      # Exec output
      exec_out_list = exec_out.split()
      exec_out_list.append(str(ret_code))
      # print(exec_out_list)

      # Status
      status=""
      if not path.exists(stdout_file):
        report_f.write("{:10s}:{}\n".format("exec out", exec_out_list))
        report_f.write("output file not exist.\n")
        continue
      else:
        # Standard output
        with open(stdout_file, "r") as f:
          stdout_list = f.read().split()
          # print(stdout_list)
          if exec_out_list == stdout_list:
            status="OK!"
            status_print="\033[32mOK!\033[0m"
            bug_num-=1
          else:
            status="ERROR!!!"
            status_print="\033[31mERROR!!!\033[0m"
            report_f.write("{:10s}:{}\n".format("std out", stdout_list))
            report_f.write("{:10s}:{}\n".format("exec out", exec_out_list))
            # print("{:10s}:{}".format("std out", stdout_list))
            # print("{:10s}:{}".format("exec out", exec_out_list))
            # print("{:10s}:{}".format("exec err", exec_err))
      if (args.all and args.verbose) or status!="OK!":
        print("{:10s}:{}\n".format("status",status_print))
        report_f.write("{:10s}:{}\n".format("status",status))
        report_f.write('\n')
    
  report_f.write("{:10s}:{:3d}\n".format("bug num",bug_num))
  if args.all and args.verbose and args.run:
    all_time_seconds+=all_time_useconds//1000000
    all_time_useconds%=1000000
    report_f.write("{:10s}:{:3d}s {:6d}us\n".format("all time",all_time_seconds, all_time_useconds))
  report_f.write("finish.\n")