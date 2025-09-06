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
import JASP


Form
{
	info: qsTr("This function computes the Bayes factor for a binomially distributed observation. The Bayesian binomial test is described in Jeffreys (1961, p. 256). This test informs us whether the data support or contradict a value suggested for the parameter (chance) in question.")

	Group
	{
		IntegerField { name: "successes";	label: qsTr("Successes")	}
		IntegerField { name: "failures";	label: qsTr("Failures")		}
		FormulaField { name: "testValue";	label: qsTr("Test value"); defaultValue: "0.5" ; max: 1; min: 0 }
		}

		Divider { }

	RadioButtonGroup
	{
		id:		hypothesis
		title:	qsTr("Alt. Hypothesis")
		name:	"alternative"
		RadioButton { value: "twoSided";	label: qsTr("\u2260 Test value"); checked: true;	info: qsTr("Two-sided alternative hypothesis that the population mean is not equal to the test value.")	}
		RadioButton { value: "greater";		label: qsTr("> Test value");						info: qsTr("One-sided alternative hypothesis that the population mean is larger than the test value.")	}
		RadioButton { value: "less";		label: qsTr("< Test value");						info: qsTr("One-sided alternative hypothesis that the population mean is smaller than the test value.")	}
	}

	Group
	{
		title: qsTr("Plots")
		CheckBox
		{
			name: "priorPosteriorPlot";		label: qsTr("Prior and posterior");		info: qsTr("Displays the prior (dashed line) and posterior (solid line) density of the effect size under the alternative hypothesis; the gray circles represent the height of the prior and the posterior density at effect size delta = 0. The horizontal solid line represents the width of the 95% credible interval of the posterior.")
			CheckBox { name: "priorPosteriorPlotAdditionalInfo"; label: qsTr("Additional info"); checked: true; info: qsTr("Displays the Bayes factor computed with the user-defined prior; displays a probability wheel depicting the odds of the data under the null vs. alternative hypothesis; displays the median and 95% credible interval of the posterior density.") }
		}
	}

	BayesFactorType { correlated: hypothesis.value }


	Group
	{
		title: qsTr("Prior")
		DoubleField { name: "betaPriorA"; label: qsTr("Beta prior: parameter a"); defaultValue: 1; max: 10000; inclusive: JASP.None; decimals: 3; info: qsTr("Sets how much prior belief you have in success. When a = b = 1, this corresponds to a uniform prior distribution.") }
		DoubleField { name: "betaPriorB"; label: qsTr("Beta prior: parameter b"); defaultValue: 1; max: 10000; inclusive: JASP.None; decimals: 3; info: qsTr("Sets how much prior belief you have in failure. When a = b = 1, this corresponds to a uniform prior distribution.") }
	}
}
