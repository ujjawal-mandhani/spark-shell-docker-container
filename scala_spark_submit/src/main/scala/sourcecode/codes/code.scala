package sourcecode.codes
import org.apache.spark.sql.SparkSession
import org.apache.log4j.Logger




object code {

	def spark_scala_function: Unit = {
		val logger: Logger = Logger.getLogger(getClass.getName)
		val spark = SparkSession.builder().enableHiveSupport().getOrCreate()		
		val df = spark.sql("select 1 as col1")
		df.show(10, false)
		logger.info("This is an INFO message")
	}
}
