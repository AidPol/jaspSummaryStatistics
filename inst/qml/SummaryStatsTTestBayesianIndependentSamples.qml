//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//


import QtQuick 2.8
import QtQuick.Layouts 1.3
import JASP.Controls
import JASP.Widgets


Form
{
	info: qsTr("This function allows you to compute Bayes factor corresponding to an independent groups t-test using the classical *t* statistic. The null hypothesis states that the population means of two independent groups are equal. This Bayesian assessment can be executed in the absence of the raw data.\n" + "## " + "Assumptions\n" + "- The observations in both groups are a random sample from the population\n" + "- The dependent variable is normally distributed in both populations\n" + "- The population variances in the two groups are homogeneous")

	Group
	{
		DoubleField  { name: "tStatistic";				label: qsTr("t"); 			visible: inputType.value === "tAndN";	negativeValues: true	}
		DoubleField  { name: "cohensD";					label: qsTr("Cohen's d");	visible: inputType.value === "cohensD"		}
		Group
		{
			columns: 2
			visible: inputType.value === "meansAndSDs"
			DoubleField  { name: "mean1";					label: qsTr("Mean 1"); negativeValues: true}	
			DoubleField  { name: "sd1";						label: qsTr("SD 1")}
		}
		Group
		{
			columns: 2
			visible: inputType.value === "meansAndSDs"
			DoubleField  { name: "mean2";					label: qsTr("Mean 2"); negativeValues: true}
			DoubleField  { name: "sd2";						label: qsTr("SD 2")}
		}
		IntegerField { name: "sampleSizeGroupOne";		label: qsTr("Sample size group 1")				}
		IntegerField { name: "sampleSizeGroupTwo";		label: qsTr("Sample size group 2")				}
    }

	RadioButtonGroup
	{
		id:		inputType
		name:	"inputType"
		title: qsTr("Input Type")
		RadioButton { value: "tAndN";			label: qsTr("t and Sample Sizes"); checked: true	}
		RadioButton { value: "cohensD";			label: qsTr("Cohen's d and Sample Sizes")			}
		RadioButton { value: "meansAndSDs";		label: qsTr("Means, SDs, and Sample Sizes")			}
	}

    Divider { }

	RadioButtonGroup
	{
		id:		hypothesis
		title:	qsTr("Alt. Hypothesis")
		name:	"alternative"
		RadioButton { value: "twoSided";	label: qsTr("Group 1 \u2260 Group 2"); checked: true;	info: qsTr("Two-sided alternative hypothesis that the population means are equal.")	}
		RadioButton { value: "greater";	  label: qsTr("Group 1 > Group 2");							info: qsTr("One-sided alternative hypothesis that the population mean of Group one is larger than the population mean of Group two.")	}
		RadioButton { value: "less";	    label: qsTr("Group 1 < Group 2");						info: qsTr("One-sided alternative hypothesis that the population mean of Group one is smaller than the population mean of Group.")		}
	}

	Group
	{
		title: qsTr("Plots")
		CheckBox
		{
			name: "priorPosteriorPlot";		label: qsTr("Prior and posterior");		info: qsTr("Displays the prior and posterior density of the effect size under the alternative hypothesis.")
			CheckBox { name: "priorPosteriorPlotAdditionalInfo";		label: qsTr("Additional info"); checked: true; info: qsTr("Shows the Bayes factor using the chosen prior, a probability wheel showing evidence for each hypothesis, and the median with 95% credible interval of the effect size.") }
		}
		CheckBox
		{
			name: "bfRobustnessPlot";	label: qsTr("Bayes factor robustness check");		info: qsTr("Displays the Bayes factor as a function of the width of the Cauchy prior on effect size. The scale of the Cauchy prior is varied between 0 and 1.5 (between 0 and 2 if user prior width is greater than 1.5), creating progressively more uninformative priors.")
			CheckBox { name: "bfRobustnessPlotAdditionalInfo";	label: qsTr("Additional info"); checked: true; info: qsTr("Displays the maximum Bayes factor in favor of the alternative hypothesis and the user Bayes factor.") }
		}
	}

	BayesFactorType { correlated: hypothesis.value }

    SubjectivePriors { }
}
