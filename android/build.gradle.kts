allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// ✅✅✅ التصحيح هنا: إجبار المشروع على استخدام نسخ قديمة متوافقة
subprojects {
    project.configurations.all {
        resolutionStrategy {
            force(
                "androidx.browser:browser:1.8.0",
                "androidx.core:core:1.13.1",
                "androidx.core:core-ktx:1.13.1"
            )
        }
    }
}
// ✅✅✅ نهاية الإضافة

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}