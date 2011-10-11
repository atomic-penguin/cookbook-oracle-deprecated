maintainer       "Eric G. Wolfe"
maintainer_email "wolfe21@marshall.edu"
license          "Apache 2.0"
description      "Installs/Configures oracle pre-requisites."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.8"
depends          "el-sysctl"
depends          "x-windows"
depends          "gnome"
conflicts        "sysctl"

%w{ redhat centos scientific }.each do |os|
  supports os, ">= 5.0"
end


# Array with required packages for Oracle 10gr2 x86 & x86_64
attribute "oracle/version",
  :display_name => "oracle/version",
  :description => "Should be 10, or 11",
  :default => "11"

attribute "oracle/dbas",
  :display_name => "oracle/dbas",
  :description => "array of dba group members",
  :type => "array",
  :default => "oracle"

attribute "oracle/required_packages",
  :display_name => "oracle/required_packages",
  :description => "Array containing Oracle pre-requisite packages",
  :calculated => true

# Number of oracle processes from init.ora files
attribute "oracle/processes",
  :display_name => "oracle/processes",
  :description => "Recommend setting this equal to the number of PROCESSES in init.ora files",
  :required => "recommended",
  :default => "240"

# PAM Security limits for oracle user
attribute "security/limits",
  :display_name => "security/limits",
  :description => "process and file PAM security limits for oracle user",
  :required => "optional"

# Calculated sysctl settings in accordance with Oracle documentation
attribute "kernel/shmmax",
  :display_name => "kernel/shmmax",
  :description => "Maximum shared segment size, in bytes. Calculated according to architecture and amount of RAM.",
  :calculated => true

attribute "kernel/semmsl",
  :display_name => "kernel/semmsl",
  :description => "Maximum number of semaphores per semaphore set. Calculated as Oracle processes + 10",
  :calculated => true

attribute "kernel/semmni",
  :display_name => "kernel/semmni",
  :description => "Maximum number of semaphore sets for the entire Linux system. Default and recommended setting is 128.",
  :required => "optional"

attribute "kernel/semmns",
  :display_name => "kernel/semmns",
  :description => "Total number of semaphores (not semaphore sets) for the entire Linux system. Calculated as semmsl * semmni",
  :calculated => true

attribute "kernel/semopm",
  :display_name => "kernel/semopm",
  :description => "Maximum number of semaphore operations that can be performed per semaphore call. Calculated equal to semmsl",
  :calculated => true

# Recommended minimum values in accordance with Oracle documentation
attribute "kernel/shmall",
  :display_name => "kernel/shmall",
  :description => "maximum number of shared memory segments, in pages. Defaults to 2097152",
  :default => "2097152"

attribute "kernel/shmmni",
  :display_name => "kernel/shmmni",
  :description => "System wide maximum number of shared memory segments. Default is 4096",
  :default => "4096",
  :required => "optional"

attribute "fs/file_max",
  :display_name => "kernel/fs/file_max",
  :description => "Maximum number of file descriptors system-wide. Default is 65536",
  :required => "optional",
  :default => "65536"

attribute "fs/aio_max_nr",
  :display_name => "fs/aio_max_nr",
  :description => "Maximum number of outstanding concurrent I/O requests",
  :required => "optional",
  :default => "65536"

attribute "net/ipv4/ip_local_port_range",
  :display_name => "net/ipv4/ip_local_port_range",
  :description => "Set available unprivileged ports. Defaults to 1024 through 65000",
  :required => "optional",
  :default => "1024 65000"

attribute "net/core/rmem_default",
  :display_name => "net/core/rmem_default",
  :description => "Default read buffer size for networking.",
  :default => "262144",
  :required => "optional"

attribute "net/core/wmem_default",
  :display_name => "net/core/wmem_default",
  :description => "Default write buffer size for networking.",
  :default => "262144",
  :required => "optional"

attribute "net/core/rmem_max",
  :display_name => "net/core/rmem_max",
  :description => "Maximum read buffer size for networking.",
  :required => "optional",
  :default => "262144"

attribute "net/core/wmem_max",
  :display_name => "net/core/wmem_max",
  :description => "Maximum write buffer size for networking.",
  :required => "optional",
  :default => "262144"
