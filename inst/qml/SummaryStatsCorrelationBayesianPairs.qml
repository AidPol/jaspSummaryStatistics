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

import QtQuick
import QtQuick.Layouts
import JASP.Controls

Form 
{
    info: qsTr("The Bayesian Correlation analysis allows you to test the null hypothesis that the population (Pearson product-moment correlation) between two variables equals 0.")

    IntegerField { name: "n"; label: qsTr("Sample size") }

    Divider { }

	RadioButtonGroup
	{
        name: "method"
        title: qsTr("Sample Correlation Coefficient")
		Layout.columnSpan: 2
		RadioButton
		{
            value: "pearson"; label: qsTr("Pearson's r"); checked: true; childrenOnSameRow: true; info: qsTr("The observed Pearson product-moment correlation coefficient.")
            DoubleField { name: "rObs"; defaultValue: 0; min: -1; max: 1 }
		}
		RadioButton
		{
            value: "kendall"; label: qsTr("Kendall's tau-b"); childrenOnSameRow: true; info: qsTr("The observed Kendall's tau-b rank-order correlation coefficient.")
            DoubleField { name: "tauObs"; defaultValue: 0; min: -1; max: 1 }
		}
        RadioButton
        {
            value: "spearman"; label: qsTr("Spearman's rho"); childrenOnSameRow: true; debug: true
            DoubleField { name: "rhoSObs"; defaultValue: 0; min: -1; max: 1 }
        }
	}


	RadioButtonGroup
	{
		id:		hypothesis
		title:	qsTr("Alt. Hypothesis")
		name:	"alternative"
        RadioButton { value: "twoSided";   label: qsTr("Correlated"); checked: true;	info: qsTr("Two-sided alternative hypothesis that the population correlation does not equal 0.")}
        RadioButton { value: "greater";    label: qsTr("Correlated positively");		info: qsTr("One-sided alternative hypothesis that the population correlation is higher than 0.")}
        RadioButton { value: "less";       label: qsTr("Correlated negatively");		info: qsTr("One-sided alternative hypothesis that the population correlation is lower than 0.")}
	}

    CheckBox
    {
        name: "ci"; label: qsTr("Credible intervals"); info: qsTr("Display central credible intervals. A credible interval shows the probability that the true effect size lies within certain values. The default credible interval is set at 95%.")
        CIField { name: "ciLevel";	label: qsTr("Interval") }
    }

	Group
	{
		title: qsTr("Plots")
		CheckBox
		{
            name: "priorPosteriorPlot";				label: qsTr("Prior and posterior");			info: qsTr("Displays the prior and posterior density of the correlation under the alternative hypothesis.")
            CheckBox { name: "priorPosteriorPlotAdditionalEstimationInfo";	label: qsTr("Estimation info"); checked: true; info: qsTr("Displays the median and 95% credible interval of the posterior density") }
            CheckBox { name: "priorPosteriorPlotAdditionalTestingInfo";	label: qsTr("Testing info"); checked: true; info: qsTr("Displays the Bayes factor; displays a probability wheel depicting the odds of the data under the null vs. alternative hypothesis; displays gray circles that represent the height of the prior and the posterior density at the testing point (rho=0). The ratio of the two densities at that point is equal to the Bayes factor.") }
		}
		CheckBox
		{
            name: "bfRobustnessPlot";                          label: qsTr("Bayes factor robustness check"); info: qsTr("Displays the Bayes factor as a function of the width of the Cauchy prior on effect size. The scale of the Cauchy prior is varied between 0 and 1.5 (between 0 and 2 if user prior width is greater than 1.5), creating progressively more uninformative priors.")
            CheckBox { name: "bfRobustnessPlotAdditionalInfo"; label: qsTr("Additional info"); checked: true; info: qsTr("Displays the maximum Bayes factor in favor of the alternative hypothesis and the user Bayes factor.") }
		}
	}

	BayesFactorType { correlated: hypothesis.value }

	Group
	{
        title: qsTr("Prior")
        DoubleField { name: "priorWidth";       label: qsTr("Stretched beta prior width");      defaultValue: 1.0; min: 0.003; max: 2; decimals: 3 }
	}
}
