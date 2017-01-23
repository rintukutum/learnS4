#--------------
# Slots
# The first stage is to define the slots of the object itself. That is done by using the
# instruction setClass.
setClass(
  Class = "Traj",
  slots = list(
    times = "numeric",
    traj = "matrix"
  ),
  #------
  # prototype
  prototype = prototype(
    time
  )
)
#HELLO
#----
# When a class exists, we can create an object of its class using the constructor new
#----
# Constructor
new(Class = "Traj")

new(Class="Traj",times=c(1,3),traj=matrix(1:4,ncol=2))

traj.A <- new(Class="Traj")
traj.B <- new(
            Class = "Traj",
            times = c(1,45,4,10),
            traj = rbind(
              c(15,15.1, 15.2, 15.2),
              c(16,15.9, 16, 16.4),
              c(15.2, NA, 15.3, 15.3),
              c(15.7, 15.6, 15.8, 16)
            )
          )
traj.C <- new(
            Class = "Traj",
            times = c(1: 10, (6: 16) *2),
            traj = rbind(
                    matrix (seq (16,19, length=21), ncol=21, nrow=50, byrow=TRUE),
                    matrix (seq (15.8, 18, length=21), ncol=21, nrow=30, byrow=TRUE)
            )+rnorm (21*80,0,0.2)
)
#----
# reach a slot
traj.B@times
#-----
# Let us create a Class with default values
setClass(
  Class = "t.Try",
  slots = list(
    time = "numeric",
    traj =  "matrix"
  ),
  prototype = prototype(
    time = 1,
    traj = matrix(0)
  )
)

try.A <- new(Class="t.Try")

removeClass("t.Try")

#------------------
# Methods
# "plot" method
size <- rnorm(n=10,mean=1.70,sd=10)
weight <- rnorm(n=10,mean=70,sd=5)
group <- as.factor(rep(c("A","B"),5))
par(mfrow=c(1,2))
plot(size~weight, main='scatterPlot-method')
plot(size~group, main='boxplot-method')

#--------------
# to create method like above we can use 'setMethod' function

setMethod(
  f = "plot",
  signature = "Traj",
  definition = function(x,y, ...){
    matplot(x@times,t(x@traj),xaxt="n",type="l",ylab= "",xlab="", pch=1)
    axis(1,at=x@times)
  }
)

par(mfrow=c (1,2))
plot(traj.B)
plot(traj.C)
#------------
# 'print' and 'show' methods
#-----------------
# new method specific to our Class
# we can create user specific methods using 'setGeneric' function

setGeneric(
  name = "countMissing",
  def = function(object){
    standardGeneric("countMissing")
  }
)

setMethod(
  f = "countMissing",
  signature = "Traj",
  definition = function(object){
    return(sum(is.na(object@traj)))
  }
)

#-----
# this will not allow to modify our 'countMissing' function
lockBinding(
  sym = "countMissing",
  env = .GlobalEnv
)


setGeneric(
  name = "countMissing",
  def = function(object, value){
    standardGeneric("countMissing")
  }
)

#-------
# to see the methods of a class
showMethods(
  class="Traj"
)

#------
# getMethod allow us to see definitions
getMethod(
  f = "plot",
  signature = "Traj"
)

#------
existsMethod(
  f="plot",
  signature="Traj"
)
# [1] TRUE
existsMethod(
  f="plot",
  signature="Hello"
)
# [1] FALSE

#-----------------------
# Construction
# - Inspector
# - The initializator
# - Constructor for user

#-----------------------
# Accessor
# - get
# - set
# - The operator "["
# - "[", "@" or "get"
