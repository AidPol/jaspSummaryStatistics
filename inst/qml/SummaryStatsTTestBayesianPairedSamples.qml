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
	info: qsTr("This function allows you to compute Bayes factor corresponding to paired groups t-test using the classical *t* statistic. The null hypothesis states that the population mean of the difference between paired observations equals 0. This Bayesian assessment can be executed in the absence of the raw data.")

	Group
	{
		DoubleField  { label: qsTr("t");					name: "tStatistic"; negativeValues: true; visible: inputType.value === "tAndN" }
		DoubleField  { label: qsTr("Cohen's d");			name: "cohensD"; visible: inputType.value === "cohensD" }
		Group
		{
			columns: 2
			visible: inputType.value === "meanDiffAndSD"
			DoubleField  { label: qsTr("Mean difference");		name: "meanDifference"; negativeValues: true}
			DoubleField  { label: qsTr("SD");					name: "sdDifference"}
		}
		IntegerField { label: qsTr("Sample size");			name: "sampleSize" }
	}

	RadioButtonGroup
	{
		title: qsTr("Input Type")
		id:		inputType
		name:	"inputType"
		RadioButton { value: "tAndN";				label: qsTr("t and Sample Size"); checked: true }
		RadioButton { value: "cohensD";				label: qsTr("Cohen's d and Sample Size")			}
		RadioButton { value: "meanDiffAndSD";		label: qsTr("Mean Diff., SD, and Sample Size") }
	}

    Divider { }

	RadioButtonGroup
	{
		id:		hypothesis
		name:	"alternative"
		title:	qsTr("Alt. Hypothesis")
		RadioButton { value: "twoSided";	label: qsTr("Measure 1 \u2260 Measure 2"); checked: true; info: qsTr("Two-sided alternative hypothesis that the population mean of the difference is not equal to 0.")	}
		RadioButton { value: "greater";		label: qsTr("Measure 1 > Measure 2");						info: qsTr("One-sided alternative hypothesis that the population mean of the difference is larger than 0.")			}
		RadioButton { value: "less";		label: qsTr("Measure 1 < Measure 2");						info: qsTr("One-sided alternative hypothesis that the population mean of the difference is smaller than 0.")			}
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
			CheckBox { name: "bfRobustnessPlotAdditionalInfo";	label: qsTr("Additional info"); checked: true;	info: qsTr("Displays the maximum Bayes factor in favor of the alternative hypothesis and the user Bayes factor.") }
		}
	}

	BayesFactorType { correlated: hypothesis.value }

    SubjectivePriors { }
}
