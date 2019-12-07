ifdef OS
  $(info Windows detected)
  RM = del /Q
  MD = mkdir
else
  $(info Linux detected)
  RM = rm -rf
  MD = mkdir -p
endif

$(info  )
